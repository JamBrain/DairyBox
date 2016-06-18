# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "scotch/box"

    # If doing multiple installs, you should install Vagrant Cachier
    # i.e. vagrant plugin install vagrant-cachier
    if Vagrant.has_plugin?("vagrant-cachier")
      # Configure cached packages to be shared between instances of the same base box.
      # More info at https://github.com/fgrehm/vagrant-cachier
      config.cache.scope = :box
    end

	config.vm.network "private_network", ip: "192.168.48.48"
#	config.vm.network "public_network"
	config.vm.hostname = "dairybox"
	config.vm.synced_folder "www", "/var/www", :mount_options => ["dmode=777", "fmode=666"]
	config.vm.synced_folder "dev", "/var/www/common/dev", :mount_options => ["dmode=775", "fmode=664"]

	config.vm.provision :shell, path: "provision/bootstrap.sh"	
end
