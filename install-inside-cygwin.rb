#!/usr/bin/env ruby
require 'fileutils'
include FileUtils

# TODO check exit codes from external processes (backticks)
# Converts from DOS style to Cygwin style (C:\tmp --> /cygdrive/c/tmp)
install_dir="#INSTALL_DIR#".downcase.gsub(":", "").insert(0, "/cygdrive/")

puts
puts 'Starting installation...'
puts

cd("/tmp") {
    `gem --version 2>&1`

    if ($?.exitstatus == 0)
        puts '  RubyGems is already installed'
    else
        puts '  retrieving and unpacking RubyGems'

        `wget -q -O - http://rubyforge.org/frs/download.php/75309/rubygems-1.8.10.tgz | tar zx`

        cd("rubygems-1.8.10") {
            puts '  installing RubyGems'
            `ruby setup.rb --no-format-executable`
        }
    end

    `chef-client --version 2>&1`

    if ($?.exitstatus == 0)
        puts '  Chef is already installed'
    else
        puts '  installing chef and related utilies'
        `gem install ohai chef --no-rdoc --no-ri`
    end
}

if (File.exist?("#{install_dir}/client.rb") && File.exist?("#{install_dir}/validation.pem"))
    puts '  copying Chef client configuration files (client.rb & validation.pem) to /etc/chef'
    mkdir("/etc/chef")
    cp(["#{install_dir}/client.rb", "#{install_dir}/validation.pem"], "/etc/chef")
else
    puts "  Chef client configuration files (client.rb & validation.pem) not found in #{install_dir}"
    puts '  --> chef-client cannot be used before these files are present in /etc/chef'
end

