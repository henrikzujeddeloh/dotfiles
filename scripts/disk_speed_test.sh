#!/bin/bash

set -e

# WRITE TEST

WRITE_TEST_FILE=${1:-dd_obs_testfile}
WRITE_TEST_FILE_EXISTS=0
if [ -e "$WRITE_TEST_FILE" ]; then WRITE_TEST_FILE_EXISTS=1; fi
# 1GiB test file
WRITE_TEST_FILE_SIZE=1074000000

if [ $EUID -ne 0 ]; then
  echo "NOTE: Kernel cache will not be cleared between tests without sudo. This will likely cause inaccurate results." 1>&2
fi

# Header
printf "Write Test"
PRINTF_FORMAT="%8s : %s\n"
printf "$PRINTF_FORMAT" 'block size' 'transfer rate'

# Block sizes of 512b 4K 64K 1M
for BLOCK_SIZE in 512  4096 65536 1048576
do
  # Calculate number of segments required to copy
  COUNT=$(($WRITE_TEST_FILE_SIZE / $BLOCK_SIZE))

  if [ $COUNT -le 0 ]; then
    echo "Block size of $BLOCK_SIZE estimated to require $COUNT blocks, aborting further tests."
    break
  fi

  # Clear kernel cache to ensure more accurate test
  [ $EUID -eq 0 ] && [ -e /proc/sys/vm/drop_caches ] && echo 3 > /proc/sys/vm/drop_caches

  # Create a test file with the specified block size
  DD_RESULT=$(dd if=/dev/zero of=$WRITE_TEST_FILE bs=$BLOCK_SIZE count=$COUNT conv=fsync 2>&1 1>/dev/null)

  # Extract the transfer rate from dd's STDERR output
  TRANSFER_RATE=$(echo $DD_RESULT | \grep --only-matching -E '[0-9.]+ ([MGk]?B|bytes)/s(ec)?')

  # Clean up the test file if we created one
  if [ $WRITE_TEST_FILE_EXISTS -ne 0 ]; then rm $WRITE_TEST_FILE; fi

  # Output the result
  printf "$PRINTF_FORMAT" "$BLOCK_SIZE" "$TRANSFER_RATE"
done




# READ TEST

READ_TEST_FILE=${1:-dd_ibs_testfile}
if [ -e "$READ_TEST_FILE" ]; then TEST_FILE_EXISTS=$?; fi
READ_TEST_FILE_SIZE=1074000000

# Exit if file exists
if [ -e $READ_TEST_FILE ]; then
  echo "Test file $READ_TEST_FILE exists, aborting."
  exit 1
fi
READ_TEST_FILE_EXISTS=1

if [ $EUID -ne 0 ]; then
  echo "NOTE: Kernel cache will not be cleared between tests without sudo. This will likely cause inaccurate results." 1>&2
fi

# Create test file
echo 'Generating test file...'
BLOCK_SIZE=65536
COUNT=$(($READ_TEST_FILE_SIZE / $BLOCK_SIZE))
dd if=/dev/urandom of=$READ_TEST_FILE bs=$BLOCK_SIZE count=$COUNT conv=fsync > /dev/null 2>&1

# Header
PRINTF_FORMAT="%8s : %s\n"
printf "$PRINTF_FORMAT" 'block size' 'transfer rate'

# Block sizes of 512b 4K 64K 1M 
for BLOCK_SIZE in 512 4096 65536 1048576
do
  # Clear kernel cache to ensure more accurate test
  [ $EUID -eq 0 ] && [ -e /proc/sys/vm/drop_caches ] && echo 3 > /proc/sys/vm/drop_caches

  # Read test file out to /dev/null with specified block size
  DD_RESULT=$(dd if=$READ_TEST_FILE of=/dev/null bs=$BLOCK_SIZE 2>&1 1>/dev/null)

  # Extract transfer rate
  TRANSFER_RATE=$(echo $DD_RESULT | \grep --only-matching -E '[0-9.]+ ([MGk]?B|bytes)/s(ec)?')

  printf "$PRINTF_FORMAT" "$BLOCK_SIZE" "$TRANSFER_RATE"
done

# Clean up the test file if we created one
if [ $READ_TEST_FILE_EXISTS -ne 0 ]; then rm $READ_TEST_FILE; fi
