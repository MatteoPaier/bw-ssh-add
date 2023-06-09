#!/usr/bin/env sh

FOLDER_NAME="SSHAgent"

# Ensure the ssh-agent is running
ssh-add -l &>/dev/null
if [ "$?" == 2 ]; then
	echo "ssh-agent is not running, exiting."
	exit 1
fi


IDS=$(rbw list --fields folder,id | grep "^$FOLDER_NAME" | cut -f2)
while read ID ; do
	read -d "\n" NAME PASS <<< $(rbw get $ID --raw | jq -r '.fields[].value')
	echo "Adding identity: $NAME"
	expect <<EOF
log_user 0
set timeout -1
spawn ssh-add $NAME
match_max 100000
expect -exact "Enter passphrase for $NAME: "
send "$PASS\n"
expect eof
EOF
done <<< "$IDS"
