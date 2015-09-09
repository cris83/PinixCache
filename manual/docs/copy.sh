#!/bin/sh

echo 'compile'
cd _theme
cd sphinx_rtd_theme-master
python setup.py install
cd ..
cd ..


echo 'build'
make html

echo 'delete'
rm -rf ../Global.html
rm -rf ../Origin.html
rm -rf ../VHost-Proxy.html
rm -rf ../VHost.html
rm -rf ../_downloads
rm -rf ../_images
rm -rf ../_sources
rm -rf ../_static
rm -rf ../_themes
rm -rf ../genindex.html
rm -rf ../index.html
rm -rf ../objects.inv
rm -rf ../search.html
rm -rf ../searchindex.js

echo 'copy'
cp -rf _build/html/* ../
