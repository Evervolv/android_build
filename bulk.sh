#!/bin/bash
. build/envsetup.sh
if [ "$1" == "-j" ]
then
 phones="`echo "$@" | cut -d " " -f 2-`"
 opt="-j"
else
 phones="$@"
 opt=""
fi

for phone in $phones
do
 lunch $phone
 make $opt
 make $opt otapackage
done
