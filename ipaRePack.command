#!/bin/bash
cd -- "$(dirname "$0")"

OLDIFS=$IFS
IFS=$'\n'
shopt -s nullglob

payDir="Payload"
archDir="_ARCHIVE"
compDir="_comparePad"
addDir="_addPad"

if [ ! -d "$archDir" ]; then
	mkdir "$archDir"
fi

for d in $(ls -d */); do
	if [ "${d%%/}" != "$archDir" -a "${d%%/}" != "$compDir" -a "${d%%/}" != "$addDir" ]; then
		# Procession folders
		echo "Packing ${d%%/}..."
		pushd "./${d%%/}/" > /dev/null 2>&1
		if [ -d "./$payDir" ]; then
			zip -r -FS "$OLDPWD/${d%%/}.ipa" ./* > /dev/null
		else
			echo "Can't find \"./$payDir\" folder, ipa creation aborted"
		fi
		popd > /dev/null 2>&1

		# Check compression result
		if [ ! -f "${d%%/}.ipa" ]; then
			echo "Can't find \"${d%%/}.ipa\" file, ipa creation aborted"
		# else
		# 	echo "Archiving ${d%%/}..."
		# 	mv "./${d%%/}" "./$archDir"
		fi
	fi
done

IFS=$OLDIFS