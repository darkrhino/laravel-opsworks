node[:deploy].each do |application, deploy|
  script "migrations" do
    migrations_instance_hostname = node[:opsworks][:layers]['php-app'][:instances].keys.sort.first

    if migrations_instance_hostname == node[:opsworks][:instance][:hostname]

      Chef::Log.info("Found migration instance.")

      interpreter "bash"
      user "ubuntu"
      cwd "#{deploy[:deploy_to]}/current"
      code <<-EOH
      php artisan migrate
      EOH
    end
  end
end
