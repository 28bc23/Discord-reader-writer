#!/bin/bash
CHANNELID=
BOt=
ARGS=("$@")

if [ "-r" == "${ARGS[0]}" ]
then
	LIMIT=1
	if [ -n "${ARGS[1]}" ]; then
		if [[ ${ARGS[1]} =~ ^[0-9]+$ ]] && [ ${ARGS[1]} -gt 0 ]; then
			LIMIT=${ARGS[1]}
		else
			echo "argument 2 must be inteager greater then 0"
			exit 2
		fi
	else
		echo "empty"
	fi

	curl -H "Authorization: Bot $BOt" -X GET "https://discord.com/api/v10/channels/$CHANNELID/messages?limit=$LIMIT" | jq -r  '.[] | "\(.author.username): \(.content)"'

elif [ "-p" == "${ARGS[0]}" ]
then
    MSG="${ARGS[*]:1}"
    curl -H "Authorization: Bot $BOt" -H "Content-Type: application/json" \
        -X POST -d "$(jq -n --arg c "$MSG" '{content:$c}')" \
        "https://discord.com/api/v10/channels/$CHANNELID/messages"
else
        echo "Z KURVY SYNU HLOUPEJ -p NEBO -r"
	exit 2
fi
