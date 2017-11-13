# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "scotch/box"
	config.vm.box_version = "2.5"

	config.exec.commands '*', directory: '/vagrant/www'

	config.vm.provider "virtualbox" do |v|
		v.memory = 1024
		v.cpus = 2
		v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/www", "1"]
	end

	config.vm.network "private_network", ip: "192.168.48.48"
#	config.vm.network "public_network"
	config.vm.hostname = "dairybox"
	config.vm.synced_folder "www", "/var/www", :mount_options => ["dmode=777", "fmode=666"]
	config.vm.synced_folder "dev", "/var/www/sandbox/dev", :mount_options => ["dmode=775", "fmode=664"]

	# Store an environment variable that lets us know what the host machine is (Windows, or a Unix)
	if Vagrant::Util::Platform.windows? then
		config.vm.provision :shell, inline: "echo \"export WINDOWS_HOST=1\nexport HOST_OS=windows\" >> /etc/profile"
	else
		config.vm.provision :shell, inline: "echo \"export UNIX_HOST=1\nexport HOST_OS=unix\" >> /etc/profile"
	end
	if Vagrant::Util::Platform.darwin? then
		config.vm.provision :shell, inline: "echo \"export MAC_HOST=1\nexport HOST_OS=mac\" >> /etc/profile"
	end
	if Vagrant::Util::Platform.linux? then
		config.vm.provision :shell, inline: "echo \"export LINUX_HOST=1\nexport HOST_OS=linux\" >> /etc/profile"
	end

	config.vm.provision :shell, path: "provision/bootstrap.sh"

	config.vm.provision :shell, inline: "mount --bind /home/vagrant/.node_modules /vagrant/www/node_modules", run: "always"

	# Mailcatcher
	config.vm.provision :shell, inline: "/home/vagrant/.rbenv/shims/mailcatcher --http-ip=0.0.0.0", run: "always"
end
