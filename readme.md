# DairyBox
<img align="right" src="https://raw.githubusercontent.com/povrazor/dairybox/master/docs/Logo.png">
DairyBox is the Web Development Toolchain for Ludum Dare's LD2015 web project. To participate and contribute to the core development, you will be using this suite of tools.

DairyBox uses: 
* **Vagrant** - A set of tools for automating and confiring Virtual Machines
* **vagrant-exec** - Plugin for Vagrant used by scripts to run remote commants
* **VirtualBox** - for hosting and running Virtual Machines
* **Scotch Box** - a flexible preconfigured LAMP-stack VM for Vagrant (Linux+Apache+MySQL+PHP)

The current Ludum Dare runs LAMP, so for now we'll also use LAMP. In the future we may switch to a custom LEMP configuration. For details, check out [JuiceBox](https://github.com/povrazor/juicebox).

## TODO: Setup
* Install Vagrant (LATEST VERSION!)
* Install Vagrant-Exec plugin: `vagrant plugin install vagrant-exec`
* Install Virtual Box (LATEST VERSION!)
* clone the repos: `git clone https://github.com/povrazor/dairybox.git ludumdev`
* `vagrant up`

After setup, your server is here: http://192.168.48.48 (`www/public`).

## TODO: Using a source Repos
* `git clone` in to the `www` directory

## TIPS
* `vagrant up`
* `vagrant suspend`


## Utilities
* **info.sh** - Get information about the VM. php.ini location, IP addresses, etc.
* **log.sh** - Get the Apache+PHP Log (use PHP function "error_log" to send errors here).

## Web Utilities
* http://192.168.48.48/utils/ (`www/public/utils`)
* **apcu.php** - Manage APCu state (fast RAM cache) - login: **root**  password: **root**
* **ocp.php** - Manage Opcache state (PHP Opcache)
* **phpinfo.php** - Simple script with a phpinfo() call.

If you want PHPMyAdmin, simply download the latest version and unzip it in to the `public/phpmyadmin` folder. Access it with.

http://192.168.48.48/phpmyadmin/ - Login: **root**  Password: **root**

## Public Server
By default, your DairyBox can only be accessed locally. To access it publicly, you need to enable the Public Server.

To do this, remove the # in front of the `"public_network"` line in your **Vagrantfile**.

The next time you start your server with `vagrant up`, you may be prompted which of your Network Interfaces you want to bind (i.e. your Ethernet or your WiFi). Once setup completes, you can use the info script to get information about the server.

`./info.sh`

The public IP is usually the IP listed under **eth2**.

## Enabling OpCache
TODO

## Configuring APCu
TODO
