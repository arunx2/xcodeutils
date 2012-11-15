#!/bin/sh

#print usual html headers
echo "<html>"
echo "<h2> Unused resources </h2>"
#usual disclaimer
echo "<i> <b>Note:</b> This scans all the xib, nib files for the images available. Please look for splash screens or other images carefully in the below list which are used in the project definition (pbxproj file)</i> <br>"
unusedfiles="";
#initialize the counter
let count=0;
# collect the files needs to be introspected
PROJ=`find . -name '*.?ib' -o -name '*.[mh]'`

for i in `find . -name "*.png" -o -name "*.jpg"`; do 
    file=`basename -s .jpg "$i" | xargs basename -s .png | xargs basename -s @2x`
    # result=`ack -i "$file"`
    # if [ -z "$result" ]; then
    # echo $file
    if ! grep -q $file $PROJ; then
        unusedfiles="$unusedfiles <br> $i";
        # echo $i
        let "count = count + 1";
    fi
done
#construct body
echo "<body>"
echo "<h3>"
echo "There are $count unused files"
echo "</h3>"
echo "<pre>"
#generate body content if there are unused files.
if [ $count > 0 ]; then
	echo $unusedfiles;
fi
echo "</pre>"

echo "</body>"
echo "</html>"
#thats it!