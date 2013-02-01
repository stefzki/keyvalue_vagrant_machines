# Key-Value Store Vagrant definitions


## Purpose

After i created the local test setup for MongoDB i recognized it would be great to have the possibility to evaluate other backend storage technologies as well. Therefore this repository contains sql backend technologies like MySQL or Postresql.

## Preconditions

Please follow the install instructions at http://vagrantup.com/. Use the latest version from vagrant and install the latest version of VirtualBox (the version from the projects homepages are recommended). After the installation, verify that virtualization options are enabled in your bios, if you are using a 'normal' pc. I did not encounter any virtualization problems on macs. 

## The machines

### simple-redis

This is a simple one machine Redis setup. It uses a standard Ubuntu base-box and installs Redis via puppet. Furthermore MySQL will be configured to run on 0.0.0.0 and a test database (called evaluation) with read and write access for root will be created.

Usage:
``` 
cd simple-redis
vagrant up
```

After this you can access Redis e.g. via https://github.com/xetorthio/jedis:

```
mysql --host=mysql01.local -u root
```

To shut down the vagrant images use:

```
vagrant halt
```
or

```
vagrant destroy
```

### simple-riak

This is a simple one machine Riak setup. It uses a standard Ubuntu base-box and installs Riak via puppet. Furthermore Riak will be configured to run on 0.0.0.0.

Usage:
``` 
cd simple-riak
vagrant up
```

After this you can verify that Riak is running by opening http://riak01.local:8098/riak/test.

To shut down the vagrant images use:

```
vagrant halt
```
or

```
vagrant destroy
```

### distributed-riak

This is work in progress - the puppet script is not ready yet.

## Evaluation proposal

To provide an easy to use evaluation tool, i created an db evaluation skeleton in Java - you can find it here https://github.com/strud/db_evaluation.