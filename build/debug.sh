#!/bin/bash

# Copy build artifacts of debug application into "launch" directory
cp -R ../card.io-ane-air/card.io-ane-debug/bin-debug/CardIOANEDebug-app.xml launch/CardIOANEDebug-app.xml
cp -R ../card.io-ane-air/card.io-ane-debug/bin-debug/CardIOANEDebug.swf launch/CardIOANEDebug.swf

#Package .ipa file
adt -package -target ipa-debug-interpreter -provisioning-profile $IOS_PROVISION -storetype pkcs12 -keystore $IOS_CERTIFICATE -storepass $IOS_CERTIFICATE_STOREPASS launch/CardIOANEDebug.ipa launch/CardIOANEDebug-app.xml -C launch CardIOANEDebug.swf -extdir launch/ext -platformsdk /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/