#!/usr/bin/env bash


exit_status=0

curl $@ || exit_status=1

if (($exit_status == 0)); then
    echo "OK: Etherdraw is running properly"
else
    echo "FAILED: we didn't get expected result from curl"
fi

exit $exit_status