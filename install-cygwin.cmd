@echo off
setlocal

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

echo   running installation of chef from inside Cygwin
%CYGWIN_HOME%\bin\bash.exe --login -c "wget --no-check-certificate -q -O /tmp/iic.rb https://raw.github.com/stigkj/chef-cygwin/develop/install-inside-cygwin.rb; sed -i 's&#INSTALL_DIR#&%CURRENT_DIR%&' /tmp/iic.rb; ruby /tmp/iic.rb"
goto end

:setup_not_found
echo.
echo setup.exe must be downloaded from http://cygwin.org and put in this directory before installation
echo.

:end
endlocal