#!/bin/bash

function wait_server_ready() {
  local port=$1
  local name=$2
  while true ; do
    curl --max-time 1 --silent http://127.0.0.1:$port
    rc=$?
    if [ $rc -eq 0 ] ; then
      echo "Application ${name} is ready on port ${port}"
      break
    fi
    sleep 1
  done
}

PORT=3001 bundle exec anycable --server-command="anycable-go" &
anycable_pid=$!
wait_server_ready 3001 "Anycable"

bundle exec rails server -p 3000 -b 0.0.0.0 &
rails_pid=$!
wait_server_ready 3000 "Rails"

# bind on $PORT automatically
bin/run &
nginx_pid=$!

function stop_all {
  kill -TERM $anycable_pid $rails_pid $nginx_pid
}

trap stop_all TERM

wait
