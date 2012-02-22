chef-cygwin
===========

> _What?! You want to use chef to manage Windows machines? Good luck with that..._

Overview
--------

I am not saying you cannot use chef under Windows. It is just that Windows lacks a package manager, which makes
installing/uninstalling/dependency handling under chef way more difficult than anyone in their right mind would deal
with. I know, I know, there are someone trying [to][1] [rectify][2] [that][3], but until that has gone through a _few_
more iterations we are left with nada. Or are we?

There is an excellent project called Cygwin that let you have quite a complete Unix/Posix environment under Windows.
And as it happens it has a decent package manager that has the features we like, with install/uninstall actions,
dependency handling and more.

The only problem is that this package manager is a GUI application which makes it unfit for our purpose. As luck will
have it, there is an _excellent_ command line package manager called [apt-cyg][4] which _do_ fit our purpose.

So, by utilizing `apt-cyg`, chef-cygwin makes it easy to install packages under Cygwin. Or wouldn't you say so:

```ruby
package "git" do
  action :install
end
```

Requirements
------------

These are the high level steps to get a Windows machine ready for using chef-cygwin:

1. Download and install cygwin (obviously)
2. Install additional packages needed by chef
    * make
    * gcc-core
    * wget
    * ruby
3. Install RubyGems
4. Install chef with related tools

Instead of doing all this manually, most of these are automated. Just follow these steps:

1. Create a new directory or use an existing as long as it is empty<br>
  **NB!** must not be the same directory as cygwin is installed into
2. Download the following files into this directory
    * [install-cygwin.cmd](install-cygwin.cmd)
    * [cygwin's setup.exe][5]
    * client.rb and validation.pem (from your chef-server installation)
3. Open cmd.exe in this directory
4. Start install-cygwin.cmd

When the script is finished, you will have a new/updated installation of Cygwin under c:\cygwin, or whatever
directory you specified.

For more information look at the [Installation on Windows][6] walk through on Opscode's wiki. Just remember that you
should **not** install RubyInstaller/RubyInstaller DevKit for Windows as this won't work properly under cygwin.


[1]: http://coapp.org
[2]: https://github.com/chocolatey/chocolatey
[3]: http://code.google.com/p/windows-package-manager
[4]: http://code.google.com/p/apt-cyg
[5]: http://cygwin.org/setup.exe
[6]: http://wiki.opscode.com/display/chef/Installation+on+Windows

