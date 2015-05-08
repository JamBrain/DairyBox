# DairyBox
<img align="right" src="https://raw.githubusercontent.com/povrazor/dairybox/master/docs/Logo.png">
DairyBox is the Web Development Toolchain for **Ludum Dare**. To contribute to the core website development, you will be using this suite of tools.

### DairyBox Uses
* **Vagrant** - A set of tools for automating and controlling Virtual Machines (VMs)
* **Virtual Box** - for hosting and running those Virtual Machines
* **Scotch/Box** - a flexible preconfigured LAMP VM for Vagrant (Linux+Apache+MySQL+PHP)

The **Ludum Dare** website runs LAMP, so for now we'll also use LAMP. In the future we may switch to a custom LEMP configuration. For details, check out [JuiceBox](https://github.com/povrazor/juicebox).

## What is Vagrant with Scotch/Box?
The key thing to understand about working with Vagrant boxes (VMs) like Scotch/Box is that Vagrant boxes are temporary. Though you can connect to the Virtual Machine and install whatever you like, Vagrant boxes work best when you install things via setup scripts. That way, they can be *nuked from orbit* whenever you like, giving you fresh/clean install whenever you want one.

In the case of Scotch/Box, the important files (i.e. the website) lives on your local machine. The Scotch/Box VM is pre-configured with a share to those files. You simply edit the files in the `www` folder, refresh your browser to see the changes, and commit/push your changes to your GIT repository once you're happy with them. Easy.

Since the files are NOT on the VM, you can safely `vagrant destroy` whenever you need to update DairyBox.

## Pre Setup (Part 0)
Where possible, install the latest versions.

* Install **GIT**: http://git-scm.com/downloads
* Install **Vagrant**: http://vagrantup.com/ (***)
* Install **Vagrant-Exec** plugin: `vagrant plugin install vagrant-exec`
* Install **Virtual Box**: https://www.virtualbox.org/wiki/Downloads (***)

If you're an Ubuntu/Debian user, **DON'T INSTALL VAGRANT AND VIRTUAL BOX USING APT-GET**! The repositories for these are **VERY** out of date. Most Vagrant setup problems on Linux are because you don't have the latest version.

## Setup Part 1: DairyBox
* Clone the DairyBox repo. 
  * **EXAMPLE:** `git clone https://github.com/ludumdare/dairybox.git ludumdare` where `ludumdare` is the directory you plan to work out of.
  * **NOTE:** DairyBox is the toolchain. For convenience, we use GIT to download and install it. Most people don't need a Fork of DairyBox. Upgrades are MUCH simpler if you don't.
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

You will be working in the `www` directory, but all Vagrant commands must be done from the root.

## Setup Part 3: Vagrant Up
* Do a `vagrant up` (from the root directory, not `www`).

After setup, your server is here: http://192.168.48.48 (`www/public`). It may take a moment to connect.

If you're running a standard **Ludum Dare** setup, additional #LDJAM services are here:
* http://192.168.48.48:8080 - api.ludumdare.com (`www/public-api`)
* http://192.168.48.48:8081 - static.ludumdare.com (`www/public-static`)
* http://192.168.48.48:8082 - ldj.am (`www/public-ldj.am`)
* http://192.168.48.48:8083 - tv.ludumdare.com (`www/public-tv`)
* http://192.168.48.48:8084 - ??? :)

For details on the structure of the **Ludum Dare** source tree, visit:

https://github.com/ludumdare/ludumdare

## Upgrading DairyBox
From your root working directory (not `www`).
* Destroy your VM with `vagrant destroy`. This shuts down the server and removes the VM.
* Pull the latest changes with `git pull -u`.
* Update your Vagrant boxes (i.e. Scotch/Box) with `vagrant box update`.
* Initialize a fresh VM with `vagrant up`.

## Tips
* `vagrant up` to initialize, start, or resume a server (after suspending or rebooting)
* `vagrant suspend` to put it to sleep
* `vagrant destroy` to delete the VM (the files in www are fine, but everything else is lost)
* `vagrant ssh` to connect to the VM with SSH

## Utilities
### Local Utilities
Things you can run from your shell.
* **info.sh** - Get information about the VM. php.ini location, IP addresses, etc.
* **log.sh** - Get the Apache+PHP Log (use PHP function "error_log" to send errors here).

### Remote Utilities
Things you can run after doing a `vagrant ssh` to connect to the server.
* **php-ini.sh** - returns the location of php.ini (often used with back-ticks when you want to edit it)
  * **EXAMPLE**: ``sudo nano `./php-ini.sh` `` To edit the php.ini
    * **CTRL+O** to Save (a prompt. You'll have to push Enter)
    * **CTRL+X** to Exit

### Web Utilities
These are some extras pre-installed on DairyBox you can access with your browser. Helpful for debugging.
* http://192.168.48.48/utils/ (`www/public/utils`)
* **apcu.php** - Manage APCu state (fast RAM cache) - login: **root**  password: **root**
* **ocp.php** - Manage Opcache state (PHP Opcache)
* **phpinfo.php** - Simple script with a phpinfo() call.

If you want PHPMyAdmin, simply download the latest version and unzip it in to the `public/phpmyadmin` directory. Access it with:

http://192.168.48.48/phpmyadmin/ - Login: **root**  Password: **root**

## Public Server
By default, your DairyBox can only be accessed locally. To access it from another machine or device on your network, you need to enable the Public Server.

To do this, remove the # in front of the `"public_network"` line in your **Vagrantfile** (`/Vagrantfile`).

The next time you start your server with `vagrant up`, you may be prompted which of your Network Interfaces you want to bind (i.e. your Ethernet or your WiFi). Once setup completes, you can use the info script to get information about the server.

`./info.sh`

The public IP is usually the IP listed under **eth2**.

Once you know your public IP address, all URLs like the http://192.168.48.48 ones above be accessed with your remote devices by using the correct IP.

## Enabling OpCache
You should only enable OpCache if you need to better simulate the active **Ludum Dare** server environment, or test OpCache aware features. For most developers, it's preferred that your PHP scripts aren't cached. That way, they reload whenever you refresh your browser.

You can clear the OpCache cache and look-up other details using the OCP tool:

http://192.168.48.48/utils/ocp.php

To Enable OpCache, do the following:

TODO

## Configuring APCu (Memory Cache)
APCu comes pre-configured in DairyBox.

The **Ludum Dare** website requires APCu. APCu is faster than Memcached (shared data is written directly to RAM instead of being piped over TCP), but is unreliable when it comes to scaling across multiple servers. Data that must be real-time accurate across multiple servers should not be cached by APCu. That said, a lot of **Ludum Dare** data can safely be wrong and out of date. For example: Changes to data **must** be read and written to the database, but data fetched by users browsing the website (comments, posts, likes, links, etc) can safely be out-of-date. In practice, the worst case has data out-of-date for a few minutes, but in many cases it wont even be a second.

**Ludum Dare** is currently run from a single dedicated server, so APCu's flaws are currently not an issue.

For caching advice, see the Development Guide.

You can check what's cached and how much memory is used with the ACPu tool:

http://192.168.48.48/utils/apcu.php

To change setting (memory usage, etc), do the following:

TODO
