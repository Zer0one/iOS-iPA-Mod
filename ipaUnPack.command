#!/bin/bash
cd -- "$(dirname "$0")"

OLDIFS=$IFS
IFS=$'\n'
shopt -s nullglob

payDir="Payload"
archDir="_ARCHIVE"

if [ ! -d "$archDir" ]; then
	mkdir "$archDir"
fi

for f in *.ipa; do
	echo "UnPacking ${f%%.ipa}..."
	unzip "$f" -d "./${f%%.ipa}" > /dev/null
	if [ -d "./${f%%.ipa}" ]; then
		if [ ! -f "./$archDir/$f" ]; then
			echo "Archiving ${f%%.ipa}..."
			mv "$f" "./$archDir"
			# cp "$f" "./$archDir"
		fi
	else
		echo "Can't find \"./${f%%.ipa}\" folder, something wrong with extraction"
	fi
done

IFS=$OLDIFS