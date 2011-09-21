Description
===========

Adds simple chef support for cygwin, that is, it uses [apt-cyg][1] as command line installer for the packages needed.

In addition it includes a cookbook with recipes for commonly needed packages under cygwin.

Requirements
============

cygwin must be installed with the following packages in addition to the standard before installing chef:

* make
* gcc-core 
* wget
* ruby

The following commands will do this automatically for you. Run them from the Windows command line (cmd) in the directory
where [cygwin's setup.exe][2] is downloaded:

```
C:\> setup -q -O -s ftp://ftp.sunet.se/pub/lang/cygwin
```

```
C:\> setup -q -O -s ftp://ftp.sunet.se/pub/lang/cygwin -P make,gcc-core,wget,ruby
```

Before installing chef, RubyGems must be installed. Run the following from within cygwin:

```
wget --no-check-certificate -q -O - https://raw.github.com/stigkj/chef-cygwin-nos/master/install-rubygems.sh | sh
```

Then chef and related tools can be installed from within cygwin:

```
gem install ohai chef --no-rdoc --no-ri
```

For more information look at the [Installation on Windows][3] walk through on Opscode's wiki. Just remember that you
should **not** install RubyInstaller/RubyInstaller DevKit for Windows as this won't work properly under cygwin.


[1]: http://code.google.com/p/apt-cyg
[2]: http://cygwin.org/setup.exe
[3]: http://wiki.opscode.com/display/chef/Installation+on+Windows