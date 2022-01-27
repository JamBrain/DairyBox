# DairyBox
<img align="right" src="https://raw.githubusercontent.com/ludumdare/dairybox/gh-pages/assets/Logo.png">

DairyBox is the web development toolchain for the **Ludum Dare** and **Jammer** event websites. To make contributions, you will be using this suite of tools.

**IMPORTANT UPDATE 2022**: Elements of Dairybox are end of life (EOL), unsutable for production, but still usable for development. We will take steps to correct this, but do understand the tooling is a bit out-of-date.


### DairyBox uses
* **Vagrant** - A set of tools for automating and controlling Virtual Machines (VMs)
* **Virtual Box** - for hosting and running those Virtual Machines
* **Scotch/Box** - a flexible preconfigured LAMP VM for Vagrant (Linux+Apache+MySQL+PHP)

The live servers **don't** run a LAMP stack, but instead run a similar bleeding-edge configuration (Linux+OpenLiteSpeed+MariaDB+PHP7).

**UPDATE 2022**: The live servers currently run some more akin to a LEMP stack (Linux+NginX+MariaDB+PHP8), but that doesn't do it justice. I'll link to a more detailed architecture breakdown in the future.


## What? Explain working with Vagrant and Scotch/Box
The key thing to understand about working with Vagrant boxes (VMs) like Scotch/Box is that Vagrant boxes are temporary. Though you can connect to the Virtual Machine and install whatever you like, Vagrant boxes work best when you install things via setup scripts. That way, they can be *nuked from orbit* whenever you like, giving you fresh/clean install whenever you want one.

In the case of Scotch/Box, the important files (i.e. the website) lives on your local machine. The Scotch/Box VM is pre-configured with a share to those files. You simply edit the files in the `www` folder, refresh your browser to see the changes, and commit/push your changes to your GIT repository once you're happy with them. Easy.

Since the files are NOT on the VM, you can safely `vagrant destroy` whenever you need to update DairyBox.


## I still don't understand
You're running a fake computer on your computer. That fake computer runs Linux. We installed everything for you, and if you break it, you can *push a button* (Vagrant) to get a brand new fake computer. You can destroy and create that fake computer as many times as you want.

Once set up, DairyBox will serve web pages to you. All you have to do is edit files and refresh your browser any time you change something. And if it ever stops working, you can blow up your fake computer using *the button* (Vagrant) and get a new one (though you probably just need to restart it).

We call that editing, clicking, and blowing up computers *the workflow*.

We call the stuff you download and install *the toolchain*.


# Pre Setup (Part 0)
First, you may need to enable virtualization support in your BIOS. How you do this will depend on your computer model or motherboard. A good place to start is Google:

https://www.google.com/#q=enable+virtualization

**ALWAYS** install the latest versions of software. If something ever stops working, make sure you **are** running the absolute latest version.

1. Install **GIT**: http://git-scm.com/downloads (*)
2. Install **Virtual Box**: https://www.virtualbox.org/wiki/Downloads (***)
3. Install **Vagrant**: http://vagrantup.com/ (***)
4. Install **Vagrant-Exec** plugins:

    ```sh
    vagrant plugin install vagrant-exec
    ```


### Linux Notes (***)
If you're an Ubuntu/Debian user, **DON'T INSTALL VAGRANT AND VIRTUAL BOX USING APT-GET**! The repositories for these are **VERY** out of date. Most Vagrant setup problems on Linux are because you don't have the latest version.

If you're on Arch Linux, you will need the **net-tools** package to make Vagrant work right. See [here](https://wiki.archlinux.org/index.php/Vagrant#No_ping_between_host_and_vagrant_box_.28host-only_networking.29).


### Windows Notes (*)
Dairybox on Windows works _best_ with a Unix environment. The latest version of **GIT** includes one (Based on **MSys**). Launch the **GIT Bash** shell to use it (may require a reboot).

**IMPORTANT**: You **MUST** run your shell as an **ADMINISTRATOR**!! This is **REQUIRED** for symlinks to work correctly.

You _can_ use the standard Windows **command prompt**, but you will need an **SSH** client to connect and build the project.

**IMPORTANT 2**: On Windows, you will run in to issues if the directory you are working out of has a space in it. You may have done this unwillingly, if you're working on your Desktop and your Windows username has a space in it.

In this case, it's recommended you create and work out of a folder on the root of your `C` drive. In the **GIT Bash** shell, this could be `/c/ludumdare/`.


# Setup Part 1: DairyBox
Clone the **DairyBox** repo.

**EXAMPLE:**

```sh
git clone https://github.com/ludumdare/dairybox.git ludumdare
```
where `ludumdare` is the directory you plan to work out of.

**NOTE:** DairyBox is the toolchain. For convenience, we use GIT to download and install it. Most people don't need a Fork of DairyBox. Upgrades are MUCH simpler if you don't.

**DO NOT** do a `vagrant up` yet. We have one more step...


# Setup Part 2: Source
Enter the `www` directory, initialize a new repository there, and set the origin to your source repository.

If you just want to try it out, or don't yet have a GitHub account, you can do the following.

```sh
cd www
git init
git remote add origin https://github.com/ludumdare/ludumdare.git
git fetch
git checkout -t origin/master
```

If you do plan to contribute changes, **fork** the `/ludumdare/ludumdare` repostiory.

You should also set up [SSH with GitHub](https://help.github.com/articles/which-remote-url-should-i-use/#cloning-with-ssh-urls) ([more info](https://help.github.com/categories/ssh/)), as it makes everything simpler (no need to generate tokens).

The recommended checkout should look something like this.

```sh
cd www
git init
git remote add origin git@github.com:YOUR-USER-NAME-ON-GIT/ludumdare.git
git remote add upstream https://github.com/ludumdare/ludumdare.git
git fetch
git checkout -t origin/master
```
Very important: don't forget the `-t`, else you'll be left with a detached head.


This will make committing your changes, and merging upstream changes easier.

We will be working in the `www` directory.


# Setup Part 3: Vagrant Up
Do a `vagrant up`.

Setup should take about 4 minutes, but longer on a brand new install (lots of downloading).

After setup, you'll be able to access VM's sandbox folder here: http://192.168.56.48. It may take a moment to connect.

The following domains have been configured to point to the VM running on your local machine:
* http://ldjam.work - **ldjam.com** (`www/public-ludumdare.com`)
  * http://api.ldjam.work - **api.ldjam.com** (`www/public-api`)
  * http://url.ldjam.work - **ldj.am** (`www/public-url.shortener`)
* http://jammer.work - **jammer.vg** (`www/public-jammer.vg`)
  * http://api.jammer.work - **api.jammer.vg** (`www/public-api`)
  * http://url.jammer.work - **jam.mr** (`www/public-url.shortener`)
* http://bio.jammer.work - **jammer.bio** (`www/public-jammer.bio`)
  * http://api.bio.jammer.work - **api.jammer.bio** (`www/public-api`)
* http://static.jammer.work - **static.jam.vg** (`www/public-static`)

Testing on remote machines and mobile devices is a bit more effort. See the [Public Server](#public-server) section below.

For details on the **Jammer/Ludum Dare** source tree, visit:

https://github.com/ludumdare/ludumdare


# Using Dairybox
## Building the Source Code and SVG Assets
There are two ways to build the source code and assets.

1. From inside the VM
2. From outside the VM (Linux/Mac only)

Common to both methods is how you build.

* `make` to compile the latest changes to the project
* `make clean` to destroy all files, and start over


### Building inside the VM
This is ready to-go after setup. Simply do the following.

```sh
vagrant ssh
cd ~/www
make
```
This compiles from inside the VM. You can repeat running `make` as many time as you like thereafter.

With the source built and the VM running, you can now view your instance in a browser at http://ldjam.work


### Building outside the VM
See [wiki/External-VM-Builds](https://github.com/ludumdare/dairybox/wiki/External-VM-Builds)


## Updating the database tables
**IMPORTANT**: When you've been working a while, ocassionally you will need to update the database tables.

You can do this by running this command:

```
sudo ~/db-create.sh
```

If you're working outside the VM, a version of `db-create.sh` can be found in the DairyBox folder (i.e. `../db-create.sh`).


## Merging Upstream
GitHub will often complain that your version is behind master. To merge the latest changes, do the following:

```sh
git fetch upstream
git checkout master         # this can be omitted if you're not working out of a branch
git merge upstream/master

git push -u
```

https://help.github.com/articles/syncing-a-fork/

https://help.github.com/articles/merging-an-upstream-repository-into-your-fork/


## Cherry-Picking
If you've made several changes and want to make a patch for specific changes, you can use Git's cherry-pick feature.

```sh
# setup
git checkout -b mybranch
git fetch upstream
git reset --hard upstream/master

# for each change you want to add to this branch
git cherry-pick <commit-hash>

# when ready to commit
git push origin mybranch:mybranch

# when finished, and you want to return to origin
git checkout master
```

Reference: http://stackoverflow.com/a/25955829/5678759


## Upgrading DairyBox
From your root working directory (not `www`).
* Destroy your VM with `vagrant destroy`. This shuts down the server and removes the VM.
* Pull the latest changes with `git pull -u`.
* Update your Vagrant boxes (i.e. Scotch/Box) with `vagrant box update`.
* Initialize a fresh VM with `vagrant up`.

If however you forked Dairybox, you will have to do something like above (Merging Upstream).


# Tips
You should **suspend** the VM before put it to sleep (or close the lid). If you forget, do a `vagrant suspend` then a `vagrant up` to resume the server.
* `vagrant up` to initialize, start, or resume a server (after suspending or rebooting)
* `vagrant suspend` to put it to sleep
* `vagrant halt` to shut it down (power button)
* `vagrant reload` to restart it
* `vagrant destroy` to delete the VM (the files in www are fine, but everything else is lost)
* `vagrant ssh` to connect to the VM with SSH


## Utilities
### Local Utilities
With **Vagrant-Exec** installed, these shell scripts are available in the Dairybox folder.
* **info.sh** - Get information about the VM. IP addresses, etc.
* **log.sh** - Get the Apache+PHP Log (use PHP function "error_log" to send errors here).


### Config File Symlinks
If you do a `vagrant ssh`, inside your home directory (`~`), you'll find symlinks to configuration files for the various software run on the webserver.
* **~/php.ini** - PHP Configuration
* **~/user.ini** - **OTHER** PHP Configuration. This is the config that enables debugging, etc.
* **~/apache2.conf** - Apache Configuration
* **~/mysql.conf** - MySQL Configuration (NB. file is actually named `my.cnf`, but symlinked with a better name)

Also, for convenience, there are symlinks to the following helpful folders:
* **~/www/** - to the WWW root folder


### Web Utilities
These are some pre-installed tools you can access with your browser. Helpful for debugging.
* http://192.168.56.48/dev/ (`../dev/`)
  * **apcu.php** - Manage APCu state (fast RAM cache) - login: **root**  password: **root**
  * **ocp.php** - Manage Opcache state (PHP Opcache)
  * **phpinfo.php** - Simple script with a phpinfo() call.
  * **phpmyadmin/** - Manage the Databases - login: **root**  password: **root**

Data can be found in the `scotchbox` database.


## Public Server
By default, your DairyBox can only be accessed on the local machine. To access it from another machine or device on your network, you need to enable the _Public Server_, and either edit your router or remote devices `.hosts` file. If you don't have SSH access or another way to change the `.hosts` file of your router/device, you **will not** be able to do this.

To start, remove the # in front of the `"public_network"` line in your **Vagrantfile** (`/Vagrantfile`).

The next time you start your server with `vagrant up`, you may be prompted which of your Network Interfaces you want to bind (i.e. your Ethernet or your WiFi). For me I choose the ``1`` option, but YMMV.

Once setup completes, you can use the info script to fetch the public IP address of the server.

```sh
./info.sh
```

The public IP is usually the IP listed under **eth2**.

The public IP address is needed to connect to the VM remotely. The domains, `jammer.work` and `ldjam.work` are configured for the default local IP address (`192.168.56.48`), and can't be used for this.

You can change the `.hosts` file of your local internet router. For details, go here:

https://github.com/ludumdare/ludumdare/wiki/Testing-on-Mobile

Alternatively, you can change the `.hosts` file of your device. Unfortunately this can mean _jailbreaking_ your phone, so modifying the `.hosts` file of the router is preferred.

Add the following domains to the `.hosts` file, and make them point to the VM's LAN IP address (**NOT** 192.168.56.48, but the IP returned by `info.sh` above).

* http://ludumdare.dev - **ludumdare.com** (`www/public-ludumdare.com`)
  * http://api.ludumdare.dev - **api.ludumdare.com** (`www/public-api`)
  * http://url.ludumdare.dev - **ldj.am** (`www/public-url.shortener`)
* http://jammer.dev - **jammer.vg** (`www/public-jammer.vg`)
  * http://api.jammer.dev - **api.jammer.vg** (`www/public-api`)
  * http://url.jammer.dev - **jam.mr** (`www/public-url.shortener`)
* http://bio.jammer.dev - **jammer.bio** (`www/public-jammer.bio`)
  * http://api.bio.jammer.dev - **api.jammer.bio** (`www/public-api`)
* http://static.jammer.dev - **static.jam.vg** (`www/public-static`)


## Enabling OpCache
You should only enable OpCache if you need to better simulate the active **Ludum Dare** server environment, or test OpCache aware features. For most developers, it's preferred that your PHP scripts aren't cached. That way, they reload whenever you refresh your browser.

You can clear the OpCache cache and look-up other details using the OCP tool:

http://192.168.56.48/dev/ocp.php

To Enable OpCache, do the following:

```sh
vagrant ssh
sudo nano ~/user.ini
```

Enable it by changing the `opcache.enable` line like so:

```
opcache.enable=1
```

Save and close the file (`CTRL+O, ENTER, CTRL+X`). Restart Apache.

```sh
sudo service apache2 restart
```

**NOTE:** You can find other configuration settings here:

http://php.net/manual/en/opcache.configuration.php


## Configuring APCu (Memory Cache)
APCu comes pre-configured in DairyBox.

The **Ludum Dare** website requires APCu. APCu is faster than Memcached (shared data is written directly to RAM instead of being piped over TCP), but is unreliable when it comes to scaling across multiple servers. Data that must be real-time accurate across multiple servers should not be cached by APCu. That said, a lot of **Ludum Dare** data can safely be wrong and out of date. For example: Changes to data **must** be read and written to the database, but data fetched by users browsing the website (comments, posts, likes, links, etc) can safely be out-of-date. In practice, the worst case has data out-of-date for a few minutes, but in many cases it wont even be a second.

For caching advice, see the Development Guide.

You can check what's cached and how much memory is used with the ACPu tool:

http://192.168.56.48/dev/apcu.php

To change setting (memory usage, etc), do edit `~/user.ini`.

**NOTE:** By default, we are not changing any of the default settings. You can find a list of possible options here:

http://php.net/manual/en/apcu.configuration.php


## Configuring e-mail for testing
You can monitor outgoing e-mails using MailHog here:

http://192.168.56.48:8025/

Any emails generated by the server will be caught and displayed there.


## Testing legacy Internet Explorer versions
**UPDATE 2022**: We are no longer supporting Internet Explorer.

Microsoft offers a variety of Virtual Machines for testing Internet Explorer 8-11 on Windows 7 and 8, as well as Microsoft Edge on Windows 10. The toolchain is already using VirtualBox, so it makes sense to grab VirtualBox images.

https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/

Unzip the downloads, and double click the `.ova` files to install them in VirtualBox.

Windows XP and Vista VM downloads are no longer officially available (with IE7 and IE8), but can be downloaded here:

https://github.com/magnetikonline/linuxmicrosoftievirtualmachines#ie8---xp

**NOTE**: Be sure to snapshot the VMs **BEFORE** starting them for the first time. The VMs use un-activated versions of Windows, and will expire after 30-90 days. With a snapshot, you can roll-back the VM and get a new 30-90 days.


## Working Offline
To work offline we must add the following to the hosts-file:

```
# For LudumDare Development
192.168.56.48 ldjam.work
192.168.56.48 api.ldjam.work
192.168.56.48 url.ldjam.work
192.168.56.48 jammer.work
192.168.56.48 api.jammer.work
192.168.56.48 url.jammer.work
192.168.56.48 bio.jammer.work
192.168.56.48 api.bio.jammer.work
192.168.56.48 static.jammer.work
```

**Note** that this must be commented out or removed for testing to be online again.

On windows in `git bash` as **administrator** you can edit it by:

```
vi /c/Windows/System32/drivers/etc/hosts
```


## When your box stops working.
1. Navigate to where you usually do `vagrant up`
2. If your box is running `vagrant halt`
3. Do `vagrant box list`, this should show you a `scotch/box`
4. Do `vagrant box remove scotch/box`. This will give you some information about an environment using the box and asking if you are really sure. Say `N`.
5. Use that long environment hex to destroy the environment: `vagrant destroy 00d3488f41fa40998bfe16ada2ebfd31` **but using your environment id**
6. Now with the environment destroyed you can do `vagrant box remove scotch/box`
7. And finally you can do `vagrant up` (this will take a long time again) and things should work nicely.
