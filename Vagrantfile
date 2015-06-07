# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "scotch/box"
	config.vm.network "private_network", ip: "192.168.48.48"
#	config.vm.network "public_network"
	config.vm.hostname = "dairybox"
	config.vm.synced_folder "www", "/var/www", :mount_options => ["dmode=777", "fmode=666"]
	config.vm.synced_folder "www/public-static", "/var/www/public/static", :mount_options => ["dmode=775", "fmode=664"]
	
	config.vm.provision "file", source: "provision/bootstrap.sh", destination: "bootstrap.sh"
	config.vm.provision "file", source: "provision/install-apcu.sh", destination: "install-apcu.sh"
	config.vm.provision "file", source: "provision/php-ini.sh", destination: "php-ini.sh"
	config.vm.provision "file", source: "provision/setup.sh", destination: "setup.sh"
	
	config.vm.provision "bootstrap", type: "shell" do |s|
		s.inline = "sudo ./bootstrap.sh"
	end
end
