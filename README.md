Description
===========

Adds simple chef support for cygwin, that is, it uses [apt-cyg][1] as command line installer for the packages needed.

In addition it includes a cookbook with recipes for commonly needed packages under cygwin.

Requirements
============

cygwin must be installed with the following packages in addition to the standard:

* git
* wget

chef must also be installed inside cygwin. First the following packages must be installed:

* make
* gcc-core 
* ruby

Then one can install chef itself:

```
gem install ohai chef --no-rdoc --no-ri
```

For more information look at the [Installation on Windows][2] walk through on Opscode's wiki. Just remember that you should **not** install RubyInstaller/RubyInstaller DevKit for Windows as this won't work properly under cygwin.


[1]: http://code.google.com/p/apt-cyg
[2]: http://wiki.opscode.com/display/chef/Installation+on+Windows