LD_FLAGS=-framework Foundation -lstdc++

all: build clean

build:
	export IPHONEOS_DEPLOYMENT_TARGET=6.0; /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang -arch i386 -Xlinker -rpath -Xlinker @executable_path/Frameworks -Xlinker -rpath -Xlinker @loader_path/Frameworks -Xlinker -objc_abi_version -Xlinker 2 -single_module -compatibility_version 1 -current_version 1 -dynamiclib -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk choose.mm -o choose.dylib.i386 $(LD_FLAGS)
	export IPHONEOS_DEPLOYMENT_TARGET=6.0; /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang -arch x86_64 -Xlinker -rpath -Xlinker @executable_path/Frameworks -Xlinker -rpath -Xlinker @loader_path/Frameworks -Xlinker -objc_abi_version -Xlinker 2 -single_module -compatibility_version 1 -current_version 1 -dynamiclib -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk choose.mm -o choose.dylib.x86_64 $(LD_FLAGS)
	export IPHONEOS_DEPLOYMENT_TARGET=6.0; /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang -arch armv7 -Xlinker -rpath -Xlinker @executable_path/Frameworks -Xlinker -rpath -Xlinker @loader_path/Frameworks -Xlinker -objc_abi_version -Xlinker 2 -single_module -compatibility_version 1 -current_version 1 -dynamiclib -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk choose.mm -o choose.dylib.armv7 $(LD_FLAGS)
	export IPHONEOS_DEPLOYMENT_TARGET=6.0; /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang -arch arm64 -Xlinker -rpath -Xlinker @executable_path/Frameworks -Xlinker -rpath -Xlinker @loader_path/Frameworks -Xlinker -objc_abi_version -Xlinker 2 -single_module -compatibility_version 1 -current_version 1 -dynamiclib -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk choose.mm -o choose.dylib.arm64 $(LD_FLAGS)
	lipo -create choose.dylib.* -output choose.dylib

clean:
	rm choose.dylib.*
