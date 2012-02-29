chef-apt-cyg
============

> _What?! You want to use chef to manage Windows machines? Good luck with that..._

Description
-----------

I am not saying you cannot use chef under Windows. It is just that Windows lacks a package manager, which makes
installing/uninstalling/dependency handling under chef way more difficult than anyone in their right mind would deal
with. I know, I know, there are someone trying [to][1] [rectify][2] [that][3], but until that has gone through a _few_
more iterations we are left with nada. Or are we?

There is an excellent project called Cygwin that let you have quite a complete Unix/Posix environment under Windows.
And as it happens it has a decent package manager that has the features we like, with install/uninstall actions,
dependency handling and more.

The only problem is that this package manager is a GUI application which makes it unfit for our purpose. As luck will
have it, there is an _excellent_ command line package manager called [apt-cyg][4] which _do_ fit our purpose.

So, by utilizing `apt-cyg`, chef-apt-cyg makes it easy to install packages under Cygwin. Or wouldn't you say so:

```ruby
package "git" do
  action :install
end
```

Requirements
------------

### High-level steps

These are the high-level steps to get a Windows machine ready for using chef-apt-cyg:

1. Download and install Cygwin (obviously)
2. Install additional packages needed by chef
    * make
    * gcc-core
    * wget
    * ruby
3. Install RubyGems
4. Install chef with related tools

### Automated install

Instead of doing this manually, most of these are automated. Just follow these steps:

1. Create a new directory or use an existing as long as it is empty<br>
  **NB!** cannot be the same directory as Cygwin is installed into
2. Download the following files into this directory
    * [install-cygwin-chef-and-apt-cyg.cmd](install-cygwin-chef-and-apt-cyg.cmd)
    * [Cygwin's setup.exe][5]
    * client.rb and validation.pem (from your chef-server installation)
3. Open cmd.exe in this directory
4. Start install-cygwin-chef-and-apt-cyg.cmd

When the script is finished, you will have a new/updated installation of Cygwin under c:\cygwin, or whatever
directory you specified.

For more information look at the [Installation on Windows][6] walk through on Opscode's wiki. Just remember that you
should **not** install RubyInstaller/RubyInstaller DevKit for Windows as this won't work properly under Cygwin.

Attributes
----------

None.

Usage
-----

Just make sure that this cookbook is selected before you start installing packages. You can add:

  include_recipe 'apt-cyg'

to all your recipes that install packages, or you can just make sure it's on the run list somewhere early on.
The cookbook itself ensures that apt-cyg is installed and up to date.

License and Author
------------------

**Author:** Stig Kleppe-Jørgensen (<from-chef-apt-cyg@nisgits.net>)<br>
**Copyright:** 2011-, Stig Kleppe-Jørgensen

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.



[1]: http://coapp.org
[2]: https://github.com/chocolatey/chocolatey
[3]: http://code.google.com/p/windows-package-manager
[4]: http://code.google.com/p/apt-cyg
[5]: http://cygwin.org/setup.exe
[6]: http://wiki.opscode.com/display/chef/Installation+on+Windows

