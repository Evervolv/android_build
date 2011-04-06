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

fail=0
for phone in $phones
do
 if [ $fail == 0 ]
 then
  if [ "gapps" != "$phone" ]
  then
   lunch $phone || fail=1
   make $opt otapackage || fail=1
  else
   make $opt gapps || fail=1
  fi
 fi
done

if [ $fail == 1 ]
then
 echo "---------------------------------"
 echo "########    ###    #### ##       "
 echo "##         ## ##    ##  ##       "
 echo "##        ##   ##   ##  ##       "
 echo "######   ##     ##  ##  ##       "
 echo "##       #########  ##  ##       "
 echo "##       ##     ##  ##  ##       "
 echo "##       ##     ## #### ######## "
fi
