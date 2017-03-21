# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "scotch/box"

	config.vm.provider "virtualbox" do |v|
		v.memory = 1024
		v.cpus = 2
	end

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
	config.vm.synced_folder "dev", "/var/www/sandbox/dev", :mount_options => ["dmode=775", "fmode=664"]

	# Store an environment variable that lets us know what the host machine is (Windows or Unix)
	if Vagrant::Util::Platform.windows? then
		config.vm.provision :shell, inline: 'echo "export WINDOWS_HOST=1" >> ~/.profile'
	else
		config.vm.provision :shell, inline: 'echo "export UNIX_HOST=1" >> ~/.profile'
	end

	config.vm.provision :shell, path: "provision/bootstrap.sh"

	# Mailcatcher
	config.vm.provision :shell, inline: "/home/vagrant/.rbenv/shims/mailcatcher --http-ip=0.0.0.0"
end
