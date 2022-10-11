# Make sure to minify the script so it works. 
# https://npm.runkit.com/bash-minifier works nicely.

online_url="https://mooshhosting.com/externalAssets/PocketMineBasic/MooshHosting.phar"
local_file="./plugins/MooshHosting.phar"
if [[ ! -f "$local_file" ]]; then
    echo "Downloading new file"
    curl -sSL $online_url >$local_file
else
    online_md5="$(curl -sL $online_url | md5sum | cut -d ' ' -f 1)"
    local_md5="$(md5sum "$local_file" | cut -d ' ' -f 1)"
    if [[ ! "$online_md5" = "$local_md5" ]]; then
        rm -rf $local_file
        curl -sSL $online_url >$local_file
    fi
fi
./bin/php7/bin/php ./PocketMine-MP.phar --no-wizard --disable-ansi
