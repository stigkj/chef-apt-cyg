chef-cygwin
===========

block quote
"What?! You want to use chef to manage Windows machines? Good luck with that..."

Overview
========

I am not saying you cannot use chef under Windows, it is just that Windows lacks a package manager. I know, I know,
there are [someone trying to rectify that][1], but until that has gone through a *few* more iterations we are left with
nada. Or are we?

There is an excellent package (noe annet??) called Cygwin that lets you have quite a complete Unix/Posix environment
under Windows. And as it happens it has a decent package manager (based on Gentoo?? ha det med??) that has the features
we like, packing install/uninstall actions, dependency handling and more.

The only problem is that this package manager is packaged up (no pun intended) as a GUI application

Have you ever wanted to use chef for setting up Cygwin-based environments, but did not know how to get chef to install
Cygwin's packages? Look no further, chef-cygwin comes to the rescue!

By utilizing the excellent [apt-cyg][2] package manager as the work engine for installing packages, installing for
example git is as simple as this:

```ruby
cygwin_package "git" do
  action :install
end
```

Requirements
============

These are the high level steps to get a Windows machine ready for using chef-cygwin to

These are the high level packages that must be installed for chef-cygwin to work:

* cygwin (obviously)
*



cygwin must be installed with the following packages in addition to the standard before installing chef:

* make
* gcc-core 
* wget
* ruby

The following commands will do this automatically for you. Run them from the Windows command line (cmd) in the directory
where [cygwin's setup.exe][3] is downloaded:

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

For more information look at the [Installation on Windows][4] walk through on Opscode's wiki. Just remember that you
should **not** install RubyInstaller/RubyInstaller DevKit for Windows as this won't work properly under cygwin.

Automated install
=================

* Download setup.exe and install-chef.cmd to c:\tmp
* Download client.rb and validator.pem to c:\tmp
* Run install-chef.cmd
 1. runs setup with standard packages
 2. runs setup with extra packages: make, gcc-core, wget and ruby
 3. starts cygwin's bash with this command to run: "wget --no-check-certificate -q -O - https://github.com/stigkj/chef-cygwin-nos/install-rest.sh | sh"
   3. install RubyGems with wget ... | sh
   4. install chef, etc. with gem install
   5. copy client.rb and validator.pem to from host OS to /etc/chef (how?)
   6. start initial chef-client run which will install:
     1. apt-cyg
     2.

[1]: find the link to the new package manager for Windows; someone at microsoft is building it
[2]: http://code.google.com/p/apt-cyg
[3]: http://cygwin.org/setup.exe
[4]: http://wiki.opscode.com/display/chef/Installation+on+Windows