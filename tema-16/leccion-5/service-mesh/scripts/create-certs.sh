#!/bin/bash

mkdir -p certs
pushd certs

make -f ../tools/Makefile.selfsigned.mk root-ca
make -f ../tools/Makefile.selfsigned.mk cluster1-cacerts
make -f ../tools/Makefile.selfsigned.mk cluster2-cacerts

popd