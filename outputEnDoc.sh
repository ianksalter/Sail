#!/bin/bash

# A utility that generates epub and pdf documents from
# the set of files stored in the source stored in the src directory
# only produces english results that is files stored in the en directory
# Uses pandoc which can be installed on a mac using home brew (and cakebrew)


#Copy source image files.
cp -r src/images target/images


# Concatenates the files in the source/en directory in alphabetic order 
# the files in the source/en directory come first then the files
# src/en/voyages then src/en/reference
# The result is a temp file used for imput to the pandoc utility which generates the files
cd src/en/
ls *.* | xargs cat > ../../target/books/en/temp_en_first.txt
cd voyages
ls *.md | xargs cat > ../../../target/books/en/temp_en_voyages.txt
cd ../reference
ls *.md | xargs cat > ../../../target/books/en/temp_en_reference.txt
cd ../../../target/books/en
cat temp_en_first.txt temp_en_voyages.txt temp_en_reference.txt > temp_en.txt
 
 
# Creates the epub file in the target directory
pandoc temp_en.txt -o main_en.epub

# Creates the pdf file in the target directory
# note it needs xelatex to work which can be
# downloaded from http://www.tug.org/ look for BasicTeX.pkg
pandoc temp_en.txt --pdf-engine=xelatex -o main_en.pdf

# Creates an output html file


# Cleanup - comment the folowing line to keep the intermediate file for debugging
rm temp_en_first.txt
rm temp_en_voyages.txt
rm temp_en_reference.txt
rm temp_en.txt
cd ../../..
rm -r target/images

# Note there is an alternative solution which avoids the intermediate file
# but the longer version was chosen for comprehensability
#ls | xargs cat | pandoc -o ../target/main.epub