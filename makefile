compile:
	swift build -Xswiftc -suppress-warnings
	sudo rm -rf /usr/bin/datarequest
	sudo cp ./.build/debug/DataRequestCLI /usr/bin/datarequest 

run: compile
	datarequest

test:

datarequest:
	swiftc -emit-module -emit-library -module-name DataRequest -c ./Sources/DataRequest/*.swift 
	swiftc -emit-library -module-name DataRequest ./Sources/DataRequest/*.swift  
