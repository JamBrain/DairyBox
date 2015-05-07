# DairyBox
<img align="right" src="https://raw.githubusercontent.com/povrazor/dairybox/master/docs/Logo.png">
DairyBox is the Web Development Toolchain for Ludum Dare. To contribute to the core development, you will be using this suite of tools.

DairyBox uses: 
* **Vagrant** - A set of tools for automating and controlling Virtual Machines
* **VirtualBox** - for hosting and running those Virtual Machines
* **Scotch/Box** - a flexible preconfigured LAMP VM for Vagrant (Linux+Apache+MySQL+PHP)

The Ludum Dare website runs LAMP, so for now we'll also use LAMP. In the future we may switch to a custom LEMP configuration. For details, check out [JuiceBox](https://github.com/povrazor/juicebox).

## Pre Setup (Part 0)
* Install **GIT**
* Install **Vagrant** (LATEST VERSION): http://vagrantup.com/
* Install **Vagrant-Exec** plugin: `vagrant plugin install vagrant-exec`
* Install **Virtual Box** (LATEST VERSION): https://www.virtualbox.org/wiki/Downloads

## Setup Part 1: DairyBox
* Clone the DairyBox repo. 
  * **EXAMPLE:** `git clone https://github.com/povrazor/dairybox.git ludumdare` where `ludumdare` is the directory you plan to work out of.
  * **NOTE:** DairyBox is the toolchain. For convenience, we use GIT to download and install it.
* **DO NOT** do a `vagrant up` yet. We have one more step...

## Setup Part 2: Source
Initialize a new repository in the `www` directory, and set the origin to your source repository.

**NOTE:** You may want to fork the `ludumdare/ludumdare` repository to your own GitHub account. If you do, adjust the `git remote` command below accordingly.

```
cd www
git init
git remote add origin https://github.com/ludumdare/ludumdare.git
git fetch
git checkout -t origin/master
cd ..
```

You will be working in the `www` directory.

## Setup Part 3: Vagrant Up
* Do a `vagrant up` (from the root directory, not `www`).

After setup, your server is here: http://192.168.48.48 (`www/public`).

If you're running a standard Ludum Dare setup, additional #LDJAM services are here:
* http://192.168.48.48:8080 - api.ludumdare.com (`www/public-api`)
* http://192.168.48.48:8081 - static.ludumdare.com (`www/public-static`)
* http://192.168.48.48:8082 - ldj.am (`www/public-ldj.am`)
* http://192.168.48.48:8083 - tv.ludumdare.com (`www/public-tv`)
* http://192.168.48.48:8084 - ??? :)

For details on the structure of the Ludum Dare source tree, go here:

https://github.com/ludumdare/ludumdare

## Tips
* Files are in `www/public/`
* `vagrant up` to initialize, start, or resume a server
* `vagrant suspend` to put it to sleep
* `vagrant destroy` to delete the VM (the files in www are fine, but everything else is lost)
* `vagrant ssh` to connect to the VM
  * ``sudo nano `./php-ini.sh` `` while SSH'ing to edit the php.ini file.

## Utilities
* **info.sh** - Get information about the VM. php.ini location, IP addresses, etc.
* **log.sh** - Get the Apache+PHP Log (use PHP function "error_log" to send errors here).

## Web Utilities
* http://192.168.48.48/utils/ (`www/public/utils`)
* **apcu.php** - Manage APCu state (fast RAM cache) - login: **root**  password: **root**
* **ocp.php** - Manage Opcache state (PHP Opcache)
* **phpinfo.php** - Simple script with a phpinfo() call.

If you want PHPMyAdmin, simply download the latest version and unzip it in to the `public/phpmyadmin` directory. Access it with.

http://192.168.48.48/phpmyadmin/ - Login: **root**  Password: **root**

## Public Server
By default, your DairyBox can only be accessed locally. To access it publicly, you need to enable the Public Server.

To do this, remove the # in front of the `"public_network"` line in your **Vagrantfile**.

The next time you start your server with `vagrant up`, you may be prompted which of your Network Interfaces you want to bind (i.e. your Ethernet or your WiFi). Once setup completes, you can use the info script to get information about the server.

`./info.sh`

The public IP is usually the IP listed under **eth2**.

## Enabling OpCache
You should only enable OpCache if you need to better simulate the active Ludum Dare server environment, or test OpCache aware features. For most development, it's preferred that your PHP scripts aren't cached.

TODO

## Configuring APCu
TODO
