action :install do
  execute "install #{new_resource.package_name}" do
    # Do not install package if it is installed already
    not_if "apt-cyg show | grep -x '#{new_resource.package_name}'"
    command "apt-cyg install #{new_resource.package_name}"
  end

  new_resource.updated_by_last_action(true)
end