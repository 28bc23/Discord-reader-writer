#!/bin/bash
CHANNELID=
BOt=
ARGS=("$@")

if [ "-r" == "${ARGS[0]}" ]
then
        curl -H "Authorization: Bot $BOt" -X GET "https://discord.com/api/v10/channels/$CHANNELID/messages?limit=${ARGS[1]}" | jq -r  '.[] | "\(.author.username): \(.content)"'

elif [ "-p" == "${ARGS[0]}" ]
then
    MSG="${ARGS[*]:1}"
    curl -H "Authorization: Bot $BOt" -H "Content-Type: application/json" \
        -X POST -d "$(jq -n --arg c "$MSG" '{content:$c}')" \
        "https://discord.com/api/v10/channels/$CHANNELID/messages"
else
        echo "Z KURVY SYNU HLOUPEJ -p NEBO -r"
fi
