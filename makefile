compile:
	swift build -Xswiftc -suppress-warnings
	sudo rm -rf /usr/bin/datarequest
	sudo cp ./.build/debug/DataRequestCLI /usr/bin/datarequest 

run:
	datarequest

test:

