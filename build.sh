#!/bin/bash
echo -e "Running XCFramework build script"
# delete previous build products
rm -rf Build
rm -rf MMKV
git clone https://github.com/Tencent/MMKV.git
'cd /MMKV'
# build package
xcodebuild archive -workspace MMKV.xcworkspace -scheme 'MMKV' -destination generic/platform=iOS -archivePath '../Build/iOS' SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
# build package
xcodebuild archive -workspace MMKV.xcworkspace -scheme 'MMKV' -destination "generic/platform=iOS Simulator" -archivePath '../Build/iOS_Simulator' SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
'cd ../Build'
# create xcframework
xcodebuild -create-xcframework -framework 'iOS.xcarchive/Products/Library/Frameworks/MMKV.framework' -framework 'iOS_Simulator.xcarchive/Products/Library/Frameworks/MMKV.framework' -output 'MMKV.xcframework'
