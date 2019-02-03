#!/bin/csh

set path = ($path /usr/local/bin)

cd /

pkg install -y git
pkg install -y autoconf
pkg install -y automake
pkg install -y libtool
pkg install -y argtable
pkg install -y nano
pkg install -y ffmpeg
pkg install -y gcc7
pkg install -y handbrake

pkg set -o devel/pkg-config:devel/pkgconf
pkg install -f devel/pkgconf