#!/bin/sh

apt-get update
apt-get install -qyf cpanminus build-essential libssl-dev libxml2-dev libexpat1-dev
cpanm -n http://cpan.metacpan.org/authors/id/A/AD/ADAMJS/App-CharmKit-2.03.tar.gz
