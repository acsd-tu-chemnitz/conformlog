#!/usr/bin/env bash
#


git clone http://www.math.lmu.de/~minlogit/git/minlog.git
cd minlog
git checkout 228f92f .
make
cp -r src ..
cp -r util ..
cp -r lib ..
cd ..
sed "s/\"---MINLOGPATH---\"/(cd)/g" src/init.scm > init.scm
rm -rf minlog
