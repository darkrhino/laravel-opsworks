node[:deploy].each do |application, deploy|
  script "migrations" do
    migrations_instance_hostname = node[:opsworks][:layers]['app-layer'][:instances].keys.sort.first

    if migrations_instance_hostname == node[:opsworks][:instance][:hostname]

      Chef::Log.debug("Found migration instance.")

      interpreter "bash"
      user "ubuntu"
      cwd "#{deploy[:deploy_to]}"
      code <<-EOH
      php artisan migrate
      EOH
    end
  end
end
