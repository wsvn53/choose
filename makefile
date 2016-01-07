LD_FLAGS=-framework Foundation -lstdc++

all: build clean codesign

build:
	export IPHONEOS_DEPLOYMENT_TARGET=6.0; /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang -arch i386 -Xlinker -rpath -Xlinker @executable_path/Frameworks -Xlinker -rpath -Xlinker @loader_path/Frameworks -Xlinker -objc_abi_version -Xlinker 2 -single_module -compatibility_version 1 -current_version 1 -dynamiclib -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk choose.mm -o choose.dylib $(LD_FLAGS); mv choose.dylib{,.i386}
	export IPHONEOS_DEPLOYMENT_TARGET=6.0; /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang -arch x86_64 -Xlinker -rpath -Xlinker @executable_path/Frameworks -Xlinker -rpath -Xlinker @loader_path/Frameworks -Xlinker -objc_abi_version -Xlinker 2 -single_module -compatibility_version 1 -current_version 1 -dynamiclib -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk choose.mm -o choose.dylib $(LD_FLAGS); mv choose.dylib{,.x86_64}
	export IPHONEOS_DEPLOYMENT_TARGET=6.0; /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang -arch armv7 -Xlinker -rpath -Xlinker @executable_path/Frameworks -Xlinker -rpath -Xlinker @loader_path/Frameworks -Xlinker -objc_abi_version -Xlinker 2 -single_module -compatibility_version 1 -current_version 1 -dynamiclib -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk choose.mm -o choose.dylib $(LD_FLAGS); mv choose.dylib{,.armv7}
	export IPHONEOS_DEPLOYMENT_TARGET=6.0; /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang -arch arm64 -Xlinker -rpath -Xlinker @executable_path/Frameworks -Xlinker -rpath -Xlinker @loader_path/Frameworks -Xlinker -objc_abi_version -Xlinker 2 -single_module -compatibility_version 1 -current_version 1 -dynamiclib -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk choose.mm -o choose.dylib $(LD_FLAGS); mv choose.dylib{,.arm64}
	lipo -create choose.dylib.* -output choose.dylib
	lipo -create choose.dylib.arm* -output choose-arm.dylib
	strip -S choose-arm.dylib

codesign:
	@echo "codesigning..";
	export CODESIGN_ALLOCATE=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/codesign_allocate; export PATH="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin:/Applications/Xcode.app/Contents/Developer/usr/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"; /usr/bin/codesign --force --sign F940F45D426B62EBF08BF2EB68CC48CAFE693BB5 choose.dylib;
	export CODESIGN_ALLOCATE=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/codesign_allocate; export PATH="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin:/Applications/Xcode.app/Contents/Developer/usr/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"; /usr/bin/codesign --force --sign F940F45D426B62EBF08BF2EB68CC48CAFE693BB5 choose-arm.dylib;

clean:
	rm choose.dylib.*
