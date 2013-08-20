# Welcome to the isitSaturday API

## The setup includes:
* box:       precise64 (http://files.vagrantup.com/precise64.box)
* webserver: apache, nodejs
* database:  mysql
* PHP:       PHP 5.3


## Next steps:
If you have not installed Vagrant yet, go to http://downloads.vagrantup.com/

Copy the contents of this archive to a new folder
and run there:

$ vagrant up

Afterwards you may access your box with

$ vagrant ssh

## After Installation:
After you have installed the box you will need to run `vagrant ssh` and then
secure your mysql installation with `mysql_secure_installation`.

Along with all server software, this intallation also comes with [phpmyadmin](http://192.168.11.9/phpmyadmin).


More documentation:
* Vagrant >= 1.1: http://docs.vagrantup.com/v2/vagrantfile/ssh_settings.html
* Vagrant <  1.1: http://docs-v1.vagrantup.com/v1/docs/getting-started/ssh.html

If you encounter any problems do not hesitate to create an issue on https://github.com/puphpet/puphpet/issues.

Enjoy!
