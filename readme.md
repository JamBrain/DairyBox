# DairyBox
DairyBox is the Web Development Toolchain for Ludum Dare's LD2015 web project. To participate and contribute to the core development, you will be using this suite of tools.

DairyBox uses: 
* Vagrant - A set of tools for automating and confiring Virtual Machines
* VirtualBox - for hosting and running Virtual Machines
* Scotch Box - a flexible preconfigured LAMP stack VM (Linux+Apache+MySQL+PHP)

The current Ludum Dare runs LAMP, so for now we'll also use LAMP. For details on the LEMP box, check out JuiceBox.

## TODO: Setup
* Install Vagrant (LATEST VERSION!)
* Install Virtual Box (LATEST VERSION!)
* Install Vagrant-Exec plugin
  `vagrant plugin install vagrant-exec`
* Checkout the repos
* `vagrant up`

After setup, your server is here: http://192.168.48.48 (`www/public`).

## TODO: Using a source Repos
* `git clone` in to the `www` directory

## Utilities
* http://192.168.48.48/utils/ (`www/public/utils`)
* apcu.php - Manage APCu state - login: **root**  password: **root**
* ocp.php - Manage Opcache state
* phpinfo.php - Simple script with a phpinfo() call.
