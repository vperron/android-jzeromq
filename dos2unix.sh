#!/bin/bash


###########################################################################
#
# Remove the trailing ^M characters added by #$%^& Windows editors
#
# Victor Perron, Orange Labs 2012 
#
# Usage : ./dos2unix 
#
###########################################################################

for f in $(\grep -Elr --binary-files=without-match --exclude-dir=.git "*" .) ; do
	echo "Cleaning $f..."
	sed -i -e 's/\r//' $f
done
