# Chef package provider for apt-cyg

require 'chef/provider/package'
require 'chef/resource/package'
require 'chef/platform'

class Chef
  class Provider
    class Package
      class AptCyg < Package
        def load_current_resource
          @current_resource = Chef::Resource::Package.new(@new_resource.name)
          @current_resource.package_name(@new_resource.package_name)
          @current_resource.version(current_installed_version)

          @current_resource
        end

        def install_package(name, version)
          apt_cyg('install', name)
        end

        # apt-cyg doesn't really have a notion of upgrading packages, just install the latest version
        alias_method :upgrade_package, :install_package

        def remove_package(name, version)
          apt_cyg('-u', 'remove', name)
        end

        # apt-cyg doesn't really have a notion of purging, so just remove
        alias_method :purge_package, :remove_package

        protected
        def apt_cyg(*args)
          run_command_with_systems_locale(
            :command => "apt-cyg #{args.join(' ')}"
          )
        end

        def current_installed_version
          get_version_from_command(
              "cat /etc/setup/installed.db | awk '/^#{@new_resource.package_name} #{@new_resource.package_name}-/ { print $2 } ' | sed 's_#{@new_resource.package_name}-(.*).tar.bz2_\1_'"
          )
        end

        def candidate_version
          get_version_from_command(
              "apt-cyg -u describe '^#{@new_resource.package_name}$' | awk '/^version: / { print $2 }' | head -1"
          )
        end

        def get_version_from_command(command)
          version = get_response_from_command(command).chomp
          version.empty? ? nil : version
        end

        # Nicked from lib/chef/package/provider/macports.rb and tweaked slightly
        def get_response_from_command(command)
          output = nil
          status = popen4(command) do |pid, stdin, stdout, stderr|
            begin
              output = stdout.read
            rescue Exception => e
              raise Chef::Exceptions::Package, "Could not read from STDOUT on command: #{command}\nException: #{e.inspect}"
            end
          end
          unless (0..1).include? status.exitstatus
            raise Chef::Exceptions::Package, "#{command} failed - #{status.inspect}"
          end
          output
        end
      end
    end
  end
end

Chef::Platform.set :platform => :cygwin, :resource => :package, :provider => Chef::Provider::Package::AptCyg