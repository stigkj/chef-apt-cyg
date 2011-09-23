@echo off

set HOME=c:\cygwin
set SITE=ftp://ftp.sunet.se/pub/lang/cygwin
set CURRENT_DIR=%~dp0
set CURRENT_DIR=%CURRENT_DIR:\=/%

echo Installing Cygwin under %HOME%...

if not exist %HOME% goto default_packages

echo   default packages already installed
goto :extra_packages

:default_packages

echo   default packages...
.\setup.exe -q -O -R %HOME% -s %SITE%


:extra_packages

if exist %HOME%\bin\make.exe goto extra_packages_exist

echo   extra packages needed (make, gcc-core, wget and ruby)...
.\setup.exe -q -O -R %HOME% -s %SITE% -P make,gcc-core,wget,ruby
goto inside_cygwin

:extra_packages_exist

echo   extra packages already installed


:inside_cygwin

echo   running installation of chef from inside Cygwin
%HOME%\bin\bash.exe --login -c "wget --no-check-certificate -q -O /tmp/iic.rb https://raw.github.com/stigkj/chef-cygwin/develop/install-inside-cygwin.rb; sed -i 's_#CURRENT_DIR#_%INSTALL_DIR%_' /tmp/iic.rb; ruby /tmp/iic.rb"




