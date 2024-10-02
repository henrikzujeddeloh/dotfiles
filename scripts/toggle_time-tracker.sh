#!/bin/bash

API_KEY="bcea212d2294a8d0ce96026f862a1199"

# check if timer is running
running=$(curl -s https://api.track.toggl.com/api/v9/me/time_entries/current -u $API_KEY:api_token)


# get workspace id
workspace=$(curl -s https://api.track.toggl.com/api/v9/workspaces -u $API_KEY:api_token | jq -r '.[].id')
echo "workspace id: " $workspace 


# get all projects
projects=$(curl -s -u $API_KEY:api_token \
    -H "Content-Type: application/json" \
    -X GET https://api.track.toggl.com/api/v9/workspaces/$workspace/projects )


# function to get project from pid
get_project() {
    echo $(echo $projects | jq '.[] | {(.id|tostring): .name}' | jq -s 'add' | jq '."'"$1"'"')
}

# function to get project name from pid
get_pid() {
    echo $(echo $projects | jq '.[] | {(.name): .id}' | jq -s 'add' | jq '.'"$1"'')
}


if [ "$running" = "null" ]; then
    # get recent time entries
    recent=$(curl -s -u $API_KEY:api_token \
        -H "Content-Type: application/json" \
        -X GET https://api.track.toggl.com/api/v9/me/time_entries | jq '.[:10] | map({pid: .pid, tag: .tags[0], desc: .description})')

    # print 10 recent time entries
    echo "Recent time entries"
    iter=0
    echo $recent | jq -c '.[]' | while IFS= read -r obj; do
    iter=$(($iter + 1))
    pid_out=$(echo "$obj" | jq -r '.pid')
    tag_out=$(echo "$obj" | jq -r '.tag')
    desc_out=$(echo "$obj" | jq -r '.desc')

    echo $iter")" $(get_project $pid_out) "-" $desc_out "("$tag_out")"
done

# select time entry to run again
read -p "select entry to run: " entry

# set variables
pid=$(echo $recent | jq '.['"$(($entry - 1))"'] | .pid')
description=$(echo $recent | jq '.['"$(($entry - 1))"'] | .desc')
tag=$(echo $recent | jq '.['"$(($entry - 1))"'] | .tag')

# send request
curl -s -u $API_KEY:api_token \
    -H "Content-Type: application/json" \
    -d '{"created_with":"toggle_time-tracker.sh","pid":'"$pid"',"description":'"$description"',"tags":['"$tag"'],"workspace_id":'"$workspace"',"duration":-1,"start":"'$(date -u +%Y-%m-%dT%H:%M:%SZ)'","stop":null}' \
    -X POST https://api.track.toggl.com/api/v9/workspaces/$workspace/time_entries >> /dev/null

else
    echo "stopping timer"
    # get current time entry
    time_entry_id=$(echo $running | jq '.id')
    
    # send request to stop currenttimer
    curl -s -u $API_KEY:api_token -X PATCH https://api.track.toggl.com/api/v9/workspaces/$workspace/time_entries/$time_entry_id/stop >> /dev/null

fi
