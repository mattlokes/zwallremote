#!/usr/bin/env bash

current=0012_4B00_02C5_A0A6
read -p "Please provide new coordinator address: " new

read -p "About to replace $current by $new. Press enter to proceed"

search=$(echo $current | sed -e 's/_//g' | sed 's/\(.\)\(.\)/\2\1/g' | rev)
replaceBy=$(echo $new | sed -e 's/_//g' | sed 's/\(.\)\(.\)/\2\1/g' | rev)

DIR=$(cd $(dirname $0); pwd)
sed -e "s/${search}/${replaceBy}/" $DIR/firmware/bin/ZWallRemote_v0_1.hex > ZWallRemote_v0_1_${new}.hex

echo "Created ZWallRemote_v0_1_${new}.hex"
