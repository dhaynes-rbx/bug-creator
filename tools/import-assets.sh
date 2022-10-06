#!/bin/bash
DIR=$(cd "$(dirname "$0")"; pwd)
cd $DIR/..
rm -rf src/Server/AssetStorage/Assets
rm -rf src/Server/AssetStorage/Scenes
remodel run tools/ImportAssets.lua
