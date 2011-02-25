#!/bin/sh

# Build the stock sdist
cd python
rm -rf dist
python setup.py sdist
cd dist

PROTO=`ls proto*.tar.gz | sed 's/.tar.gz//'`
PROTOTGZ="$PROTO.tar.gz"
tar xfz $PROTOTGZ
rm $PROTOTGZ

# Expand and fix the sdist package
cd $PROTO
mv setup.py setup_orig.py
sed 's#[.][.]/src#./src#g' < setup_orig.py > setup.py
cp -R ../../../src .
cp -R ../../ez_setup.py .
cd ..

# Rebuild the package
tar cfz $PROTOTGZ $PROTO
rm -rf $PROTO

TGZPATH=$PWD/$PROTOTGZ
echo "\n\nYour new pip-ready $PROTOTGZ is ready at '$TGZPATH'."
