#!/bin/bash

# A utility that generates html files
# the set of files stored in the source stored in the src directory
# only produces english results that is files stored in the en directory
# Uses pandoc which can be installed on a mac using home brew (and cakebrew)


#Copy source image files doesnt apear necessary why? Suspect html is using the src file TODO: Investigate
#cp -r src/images target/html/images 

echo 'Generating voyages html'
# Generate the voyages files
cd src/en/voyages
for file in *
do
	source=$file
	extension='.html'
	targetPath='../../../target/html/en/voyages/'
	target=$targetPath$source$extension
	pandoc $source -o $target
done

echo 'Generating reference html'
# Generate the reference files
cd ../reference
for file in *
do
	source=$file
	extension='.html'
	targetPath='../../../target/html/en/reference/'
	target=$targetPath$source$extension
	pandoc $source -o $target
done

echo 'Moving back to working directory'
# Move back to working directory
cd ../../..

# Note there is an alternative solution which avoids the intermediate file
# but the longer version was chosen for comprehensability
#ls | xargs cat | pandoc -o ../target/main.epub