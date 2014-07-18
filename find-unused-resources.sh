#!/bin/sh

#print usual html headers
echo "<html>"
echo "<h2> Unused resources </h2>"
#usual disclaimer
echo "<i> <b>Note:</b> This scans all the xib, nib files for the images available. Please look for splash screens or other images carefully in the below list which are used in the project definition (pbxproj file).<br>In order for links to work the report file must be in the same folder as project.</i>"
unusedfiles="";
#initialize the counter
let count=0;
let totalsize=0;
# collect the files needs to be introspected
project=`find $1 -name '*.?ib' -o -name '*.[mh]' -o -name '*.storyboard'`

for i in `find $1 -name '*.gif' -o -name '*.jpg' -o -name '*.png' -o -name '*.jpeg'`; do
file=`basename -s .jpg "$i" | xargs basename -s .png | xargs basename -s @2x`
if ! grep -q $file $project; then
filesize=`stat -f "%z" $i`;
filesizekb=`echo "$filesize 1024.0" | awk '{printf "%.2f", $1 / $2}'`
unusedfiles="$unusedfiles <br> <a href=\"$i\">$i</a> ($filesizekb kb)";
let "count += 1";
let "totalsize += $filesize"
fi
done
#construct body
totalsizekb=`echo "$totalsize 1024.0" | awk '{printf "%.2f", $1 / $2}'`
echo "<body>"
echo "<h3>"
echo "There are $count unused images (total size: $totalsizekb kb)"
echo "</h3>"
echo "<pre>"
#generate body content if there are unused files.
if [ $count > 0 ]; then
echo $unusedfiles;
fi
echo "</pre>"
#---------------------------------------------------------------------------------------
# Experimental util to find the source files which are not defined in pbxproj definition.
#---------------------------------------------------------------------------------------
count=0;
unusedfiles="";
project=`find $1 -name '*.pbxproj'`

for i in `find $1 -name "*.[hmca]" -o -name "*.cpp"`; do
file=`basename "$i"`
if ! grep -q $file $project; then
unusedfiles="$unusedfiles <br> $i";
let "count = count + 1";
fi
done
echo "<i> <b>Note:</b> This scans all source files (*.h, *.m, *.c, *.a, *.cpp) references in all pbxproj definitions. Once it is added into project definitions, it is considered being used.</i> <br>"

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
