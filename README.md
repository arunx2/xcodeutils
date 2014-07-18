xcodeutils
-----------

Some useful utilities to help iOS development

<b>find-unused-resource.sh </b>

A small utility which generates a report of unused resources (gif,jpg,png,jpeg) in the xcode project. Searches all the source folders( .h, .m) and user interface definitions (.xib, .nib ، .storyboard). This will generate a list of candidates for cleaning up.

We now support gif,jpg,png,jpeg image File.
We now support .storyboard file

<i>False positives:</i> <br>
<ul>
<li>Since project.pbxproj is not scaned, there might be false positives on the splash screens used in the project definition. 
<li>If any resources used runtime in the code like <i>"image_%d", 1</i> image_1.png is a false positive.
</ul>

<i>How to use</i>
~~~
$>sh ./find-unused-resources.sh path-to-project > report-name

ex: find-unused-resources.sh ~/myproject > unused.html
~~~
