#!/bin/bash

API_TOKEN=179d878a17e4e95b01e38dd180ad4788f650d483693ec768ba1c22d44d7d

curl -sSf -o /dev/null -u jsonrpc:$API_TOKEN --json '{"jsonrpc": "2.0", "method": "createTask", "params": {"title": "'$1'", "project_id": 1, "owner_id": 1, "creator_id": 1, "swimlane_id": 1}}' https://kanboard.henrikz.net/jsonrpc.php
