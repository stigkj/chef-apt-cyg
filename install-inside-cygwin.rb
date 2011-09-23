#!/usr/bin/env ruby
require 'fileutils'
include FileUtils

# TODO check exit codes from external processes (backticks)
#INSTALL_DIR=#INSTALL_DIR#

puts
puts 'Starting installation...'
puts

cd("/tmp") { |dir|
    `gem --version`

    if ($?.exitstatus == 0)
        puts '  RubyGems is already installed'
    else
        puts '  retrieving and unpacking RubyGems'

        `wget -q http://rubyforge.org/frs/download.php/75309/rubygems-1.8.10.tgz | tar zxvf rubygems-1.8.10.tgz`

        cd("rubygems-1.8.10") { |dir|
            puts '  installing RubyGems'
            `ruby setup.rb --no-format-executable`
        }
    end

    `chef-client --version`

    if ($?.exitstatus == 0)
        puts '  Chef is already installed'
    else
        puts '  installing chef and related utilies'
        `gem install ohai chef --no-rdoc --no-ri`
    end
}

dir = INSTALL_DIR.regexp("C:\ --> /cygdrive/c").regexp("\ --> /")

if (File.exist?("$dir/client.rb") && File.exist?("$dir/validation.pem"))
    mkdir("/etc/chef")
    cp(["$dir/client.rb", "$dir/validation.pem"], "/etc/chef")
end

