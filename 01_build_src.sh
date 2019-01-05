#!/bin/sh -l

go build -o xmiss .

rm -rf myapp
mkdir myapp
cp xmiss myapp