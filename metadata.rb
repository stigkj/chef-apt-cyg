name              'apt-cyg'
maintainer        'Stig Kleppe-Jørgensen'
maintainer_email  'from.chef-aptcyg@nisgits.net'
license           'MIT'
description       'Installs apt-cyg package manager and use it as your package provider in cygwin'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '0.0.1'
recipe            'apt-cyg', 'Install apt-cyg'
supports          'cygwin'
