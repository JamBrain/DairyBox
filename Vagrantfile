# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "scotch/box"
	config.vm.network "private_network", ip: "192.168.48.48"
#	config.vm.network "public_network"
	config.vm.hostname = "dairybox"
	config.vm.synced_folder "www", "/var/www", :mount_options => ["dmode=777", "fmode=666"]
	config.vm.synced_folder "www/public-static", "/var/www/public/static", :mount_options => ["dmode=775", "fmode=664"]
	config.vm.synced_folder "dev", "/var/www/public/dev", :mount_options => ["dmode=775", "fmode=664"]

	config.vm.provision :shell, path: "provision/bootstrap.sh"	
end
