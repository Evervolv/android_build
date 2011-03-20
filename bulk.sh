#!/bin/bash
. build/envsetup.sh
if [ "-j" == "${1:0:2}" ]
then
 phones="`echo "$@" | cut -d " " -f 2-`"
 opt="$1"
else
 phones="$@"
 opt=""
fi

for phone in $phones
do
 if [ "gapps" != "$phone" ]
 then
  lunch $phone
  make $opt otapackage
 else
  make $opt gapps
 fi
done
