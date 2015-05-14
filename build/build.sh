#!/bin/bash

unzip -o card.io.swc

unzip -o default/card.io-default.swc -d default

# copy library to be included into ANE
mkdir -p ios
cp -R -L -f ../card.io-ane-ios/CardIO/Pods/CardIO/CardIO/libCardIO.a ios/libCardIO.a

adt -package -storetype pkcs12 -keystore $AIR_CERTIFICATE -storepass $AIR_CERTIFICATE_STOREPASS -target ane card.io.ane extension.xml -swc card.io.swc -platform iPhone-ARM library.swf -platformoptions platform-ios.xml -C ios . -platform default -C default library.swf

#copy ANE into bin directory
cp -R card.io.ane ../bin/card.io.ane

# copy ANE for debug project
cp -R card.io.ane ../card.io-ane-air/card.io-debug/ane/card.io.ane

mkdir -p launch/ext
cp -R card.io.ane launch/ext/card.io.ane
unzip -o launch/ext/card.io.ane -d launch/ext

rm library.swf
rm catalog.xml

rm default/library.swf
rm default/catalog.xml