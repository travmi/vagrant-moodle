#Vagrant Moodle Environment

This environment spins up a Vagrant box with the following installed/configured.
This sets up the environment for running Moodle.

###Packages

- Percona MySQL 5.5.x
- PostgreSQL 9.4
- NGINX 1.6.x
- Apache 2.4.x
- PHP 5.5.x, Redis and ssh2-beta extensions
- git, curl, wget, vim, rsync, gcc, gcc-c++, make, unzip
- libssh2, libssh2-devel, lua, lua-devel
- V8, V8-devel, PLV8
- Virtual host files for NGINX and Apache are already configured
- Firewall and SELINUX are disabled

### Repositories Installed

- EPEL
- Webtatic
- Percona
- NGINX
- Postgres

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
4. SSH into your VM
```
# ssh root@172.16.46.5
Password is vagrant
```

###Install Site Code

Vagrant creates a shared folder at /vagrant which is the root of your project.
Place site code in here to copy to /var/www/local/moodle.local.lan. Be sure to change 
ownership to Apache.

You will need to add the moodle code to /var/www/local/moodle.local.lan/htdocs.
Moodledata directory is already added with correct permissions.

To get a Broadway site installed you will need to follow documentation [here](http://confluence.mpi.local/display/projects/Broadway+installation+documentation)

To install a generic Moodle site follow documentation [here](https://docs.moodle.org/28/en/Installing_Moodle)

###NGINX Configuration

NGINX is configured to listen to all traffic on port 80. It will serve out static 
content and all other traffic will be routed to port 8080 on localhost.

###Apache Configuration

Apache is configured to listen on port 8080. It does most of the workload for PHP.

###PHP Packages Installed

- php55w 
- php55w-opcache 
- php55w-cli 
- php55w-devel 
- php55w-gd 
- php55w-intl 
- php55w-mbstring 
- php55w-mcrypt 
- php55w-mysql 
- php55w-pgsql 
- php55w-soap 
- php55w-xml 
- php55w-common 
- php55w-pear 
- php55w-xmlrpc

###MySQL Configuration

Configured to setup a database/user and apply appropriate grants.

MySQL administration credentials:

- **Username:** root
- **Password:** *leave blank*

Moodle site connection settings:

- **Server:** localhost
- **Database:** moodle
- **Username:** 'moodle'@'localhost'
- **Password:** password

**Creating another database**

Run the following from the mysql cli.
```
# CREATE DATABASE moodle DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
# CREATE USER 'moodle'@'localhost' IDENTIFIED BY 'password';
# GRANT ALL PRIVILEGES ON moodle.* TO 'moodle'@'localhost';
# FLUSH PRIVILEGES;
```

###PostgreSQL Configuration

You will need to configure the Postgres database yourself if you decide to use it.
Official documentation can be found [here](http://confluence.mpi.local/display/projects/CourseStage+PostgreSQL+transcript+storage+configuration). 

**Create Database:**
```
[root@server ~]# su postgres
bash-4.1$ psql

psql (9.2.1)
Type "help" for help.
postgres=# CREATE USER example WITH ENCRYPTED PASSWORD 'MyComplicatedPassword!';
CREATE ROLE
posgres=# CREATE DATABASE example OWNER example;
CREATE DATABASE
```

**Setup extensions for the database:**
```
posgres=# \q
bash-4.1$ psql example

psql (9.2.1)
Type "help" for help.
For Broadway
	example=# CREATE EXTENSION "plv8";
	CREATE EXTENSION
	example=# CREATE EXTENSION "uuid-ossp";
	CREATE EXTENSION
	example=#
For Apollo
	example=# CREATE EXTENSION "pgcrypto";
	CREATE EXTENSION
```

Coursestage will complete bootstrapping the database the first time 
the transcript cron is run.
```
php /var/www/site-location/htdocs/ext/transcript/store/cron.php
```
**Run fixfuncts.sql on database afterwards.**
```
bash-4.1$ psql example < ~/fixfuncts.sql
```

**Rehydrate the transcript store**

```
php /var/www/site-location/htdocs/ext/transcript/store/rehydrate.php
```

Run the transcript cron again to see when re-hydration is complete.

```
php /var/www/site-location/htdocs/ext/transcript/store/cron.php
```

# Adding Additional Sites

1. Copy the current NGINX and Apache virtual host file and configure them.
2. Create another MySQL database.
3. Configure another PostgreSQL database.
4. Install the code.
5. Reload Apache and NGINX.

##Development
This Vagrant box was created using Packer. The repository for this build can be found [here](https://github.com/travmi/packer-moodle.git)