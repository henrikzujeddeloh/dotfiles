#!/usr/bin/env bash

curl -sSf -o /dev/null -u jsonrpc:$KANBOARD_API --json '{"jsonrpc": "2.0", "method": "createTask", "params": {"title": "'$1'", "project_id": 1, "owner_id": 1, "creator_id": 1, "swimlane_id": 1}}' https://kanboard.henrikz.net/jsonrpc.php
