#!/bin/sh

echo "Running tests...."
lua rbxobfusc.lua tests/TestFile.rbxlx tests/TestFileOutput.rbxlx &>/dev/null > /dev/null
rc=$?
if [[ $rc != 0 ]]; then
echo "Test failed!"
exit $rc
fi
echo "Test compiled."
