#!/bin/bash

#script for evervolv written by cocide
#will pull gapps related packages off the primary connected phone using adb and put the files into the gapps folder inside the repo ($directory)

directory="vendor/evervolv/GAPPS"

mkdir -p $directory/system/etc/permissions
echo -n "com.google.android.maps.xml  "
adb pull /system/etc/permissions/com.google.android.maps.xml $directory/system/etc/permissions/
echo -n "features.xml  "
adb pull /system/etc/permissions/features.xml $directory/system/etc/permissions/

mkdir -p $directory/system/framework
echo -n "com.google.android.maps.jar  "
adb pull /system/framework/com.google.android.maps.jar $directory/system/framework/

mkdir -p $directory/system/lib
echo -n "libmicrobes_jni.so  "
adb pull /system/lib/libmicrobes_jni.so $directory/system/lib/
echo -n "libspeech.so  "
adb pull /system/lib/libspeech.so $directory/system/lib/
echo -n "libvoicesearch.so  "
adb pull /system/lib/libvoicesearch.so $directory/system/lib/

#make the folder if needed
mkdir -p $directory/system/app

#set up 2 arrays first with the apk name second with the package name (to be used as a 2x## array, so make sure the entries match)
app0=( Vending.apk Maps.apk Gmail.apk talkback.apk soundback.apk GoogleBackupTransport.apk CarHomeGoogle.apk GoogleCalendarSyncAdapter.apk GoogleContactsSyncAdapter.apk YouTube.apk Twitter.apk googlevoice.apk VoiceSearch.apk GoogleServicesFramework.apk Talk.apk Facebook.apk GenieWidget.apk LatinImeTutorial.apk GoogleFeedback.apk MarketUpdater.apk Microbes.apk SetupWizard.apk OneTimeInitializer.apk GoogleQuickSearchBox.apk kickback.apk Street.apk GooglePartnerSetup.apk NetworkLocation.apk MediaUploader.apk CarHomeLauncher.apk )

app1=( com.android.vending com.google.android.apps.maps com.google.android.gm com.google.android.marvin.talkback com.google.android.marvin.soundback com.google.android.backup com.google.android.carhome com.google.android.syncadapters.calendar com.google.android.syncadapters.contacts com.google.android.youtube com.twitter.android com.google.android.apps.googlevoice com.google.android.voicesearch com.google.android.gsf com.google.android.talk com.facebook.katana com.google.android.apps.genie.geniewidget com.google.android.latinimetutorial com.google.android.feedback com.android.vending.updater com.android.livewallpaper.microbesgl com.android.setupwizard com.google.android.onetimeinitializer com.google.android.googlequicksearchbox com.google.android.marvin.kickback com.google.android.street com.google.android.partnersetup com.google.android.location com.google.android.apps.uploader com.android.cardock )

#get a list of what is in /data/app on the phone
data=`adb shell ls /data/app | tr "\r\n" " "`

#go threw the list and the array, see what we have updated, if we have one then grab it
for (( i=0; i<${#app0[@]}; i++ ))
do
 name=${app1[$i]}
 echo $data | grep -woq "${app1[$i]}[-0-9]*.apk"

 if [ $? -eq 0 ]
  then
   result="adb pull /data/app/" 
   result="$result"`echo $data | grep -wo "${app1[$i]}[-0-9]*.apk"`
   result="$result $directory/system/app/${app0[$i]}"
  else
   result="adb pull /system/app/" 
   result="$result${app0[$i]}"
   result="$result  $directory/system/app/${app0[$i]}"
  fi
 echo -n "${app0[$i]}  "
 `$result`

done
