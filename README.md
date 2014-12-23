#Vagrant Moodle Environment

This environment spins up a Vagrant box with the following installed/configured.
This sets up the environment for running Moodle.

- Percona MySQL 5.5.x
- PostgreSQL 9.4
- NGINX 1.6.x
- Apache 2.4.x
- PHP 5.5.x
- Virtual host files for NGINX and Apache are already configured
- Firewall and SELINUX are disabled

##Prerequisites

In order to run this box you will need the latest version of Vagrant, Virtualbox and GIT.

- [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads.html)
- [GIT](http://git-scm.com/downloads)

Be sure to add Vagrant to your environment path after you download it.

##Getting Started

1. Open a GIT shell and go to a location of your choice.
2. Clone the repository 
```
# git clone https://github.com/travmi/vagrant-moodle.git
# cd vagrant-moodle
```
3. Start the Vagrant instance
```
# vagrant up
```

You will need to add the moodle code to /var/www/local/moodle.local.lan/htdocs.
Moodledata directory is already added with correct permissions.

##Development
This Vagrant box was created using Packer. The repository for this build can be found [here](https://github.com/travmi/packer-moodle.git)