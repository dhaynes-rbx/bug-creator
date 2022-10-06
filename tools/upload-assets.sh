#!/bin/bash
DIR=$(cd "$(dirname "$0")"; pwd)
cd $DIR/..
if [ ! -f ~/.roblosecurity ]; then
    echo "This script requires your Roblox security token, please grab it from your .ROBLOSECURITY cookie in your browser and paste it here"
    echo -n "Token: "
    read token
    echo $token > ~/.roblosecurity
fi
tarmac sync --target roblox --auth `cat ~/.roblosecurity` .