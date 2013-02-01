# SQL Vagrant definitions


## Purpose

After i created the local test setup for MongoDB i recognized it would be great to have the possibility to evaluate other backend storage technologies as well. Therefore this repository contains sql backend technologies like MySQL or Postresql.

## Preconditions

Please follow the install instructions at http://vagrantup.com/. Use the latest version from vagrant and install the latest version of VirtualBox (the version from the projects homepages are recommended). After the installation, verify that virtualization options are enabled in your bios, if you are using a 'normal' pc. I did not encounter any virtualization problems on macs. 

## The machines

### simple-mysql

This is a simple one machine MySQL setup. It uses a standard Ubuntu base-box and installs MySQL via puppet. Furthermore MySQL will be configured to run on 0.0.0.0 and a test database (called evaluation) with read and write access for root will be created.

Usage:
``` 
cd simple-mysql
vagrant up
```

After this you can access MySQL by calling your commandline mysql client:

```
mysql --host=mysql01.local -u root
```

or use your preferred MySQL client.

To shut down the vagrant images use:

```
vagrant halt
```
or

```
vagrant destroy
```

### simple-postresql

This is a simple one machine Postresql setup. It uses a standard Ubuntu base-box and installs Postresql via puppet. Furthermore Postresql will be configured to run on 0.0.0.0 and a test database with read and write access for root will be created.

Usage:
``` 
cd simple-postgresql
vagrant up
```

After this you can access Postgresql with your preferred SQL client on host postgresql01.local.

To shut down the vagrant images use:

```
vagrant halt
```
or

```
vagrant destroy
```

## Evaluation proposal

To provide an easy to use evaluation tool, i created an db evaluation skeleton in Java - you can find it here https://github.com/strud/db_evaluation.