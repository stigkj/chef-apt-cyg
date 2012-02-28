@echo off
﻿setlocal EnableDelayedExpansion

set CYGWIN=nodosfilewarning
set CYGWIN_HOME_DEFAULT=c:\cygwin
set SITE=ftp://ftp.sunet.se/pub/lang/cygwin
set CURRENT_DIR=%~dp0
set CURRENT_DIR=%CURRENT_DIR:\=/%

if not exist setup.exe goto setup_not_found

set /p CYGWIN_HOME="Specify alternative Cygwin installation directory (default is %CYGWIN_HOME_DEFAULT%, must not exist): "

if "%CYGWIN_HOME%"=="" set CYGWIN_HOME=%CYGWIN_HOME_DEFAULT%

echo.
echo Installing Cygwin under %CYGWIN_HOME%...

if not exist %CYGWIN_HOME% goto default_packages

echo   default packages already installed
goto :extra_packages

:default_packages

echo   default packages...
.\setup.exe -q -O -R %CYGWIN_HOME% -s %SITE%


:extra_packages

if exist %CYGWIN_HOME%\bin\make.exe goto extra_packages_exist

echo   extra packages needed (make, gcc-core, wget and ruby)...
.\setup.exe -q -O -R %CYGWIN_HOME% -s %SITE% -P make,gcc-core,wget,ruby
goto inside_cygwin

:extra_packages_exist

echo   extra packages already installed


:inside_cygwin

echo   rebasing all programs/libraries
%CYGWIN_HOME%\bin\dash.exe -c "/bin/rebaseall"

echo   running installation of chef from inside Cygwin

@REM Everything from ___DATA___ (see below) and to the end of this file is a ruby script that is to be run
@REM inside Cygwin. By way of some magic (see the next 2 lines) these lines are extracted into the file /tmp/iic.rb.
﻿for /f "delims=:" %%a in ('findstr -n "^___" %0') do set "Line=%%a"
(for /f "skip=%Line% tokens=* eol=_" %%a in ('type %0') do echo(%%a) > %CYGWIN_HOME%\tmp\iic.rb

%CYGWIN_HOME%\bin\bash.exe --login -c "ruby /tmp/iic.rb"
goto end

:setup_not_found
echo.
echo setup.exe must be downloaded from http://cygwin.org and put in this directory before installation
echo.

:end
goto :EOF
endlocal


___DATA___
#!/usr/bin/env ruby
require 'fileutils'
include FileUtils

# TODO check exit codes from external processes (backticks)
# Converts from DOS style to Cygwin style (C:\tmp --> /cygdrive/c/tmp)
install_dir="!CURRENT_DIR!".downcase.gsub(":", "").insert(0, "/cygdrive/")

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
    mkdir_p("/etc/chef")
    cp(["#{install_dir}/client.rb", "#{install_dir}/validation.pem"], "/etc/chef")
    # Make sure the files are readable
    chmod 0644, %w(/etc/chef/client.rb /etc/chef/validation.pem)

    puts '  initial run of chef'
    `chef-client -N cygwin`
else
    puts "  Chef client configuration files (client.rb & validation.pem) not found in #{install_dir}"
    puts '  --> chef-client cannot be used before these files are present in /etc/chef'
end
