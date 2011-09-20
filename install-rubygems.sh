#!/bin/sh

cd /tmp
wget http://rubyforge.org/frs/download.php/75309/rubygems-1.8.10.tgz
tar zxf rubygems-1.8.10.tgz
cd rubygems-1.8.10
ruby setup.rb --no-format-executable
