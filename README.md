Swuppet
=======

Hopefully this repo will contain the code to deploy an OpenStack Swift Havana cluster with geo-replication (ie. a replication network) using Puppet and some kind of vitualization technology such as Vagrant + Virtualbox and/or LXC.


```
$ vagrant up
$ vagrant ssh keystone-01
vagrant@keystone-01:~$ sudo puppet module install puppetlabs/apt
vagrant@keystone-01:~$ sudo puppet module install puppetlabs/ntp
vagrant@keystone-01:~$ sudo puppet apply /vagrant/manifests/site.pp --modulepath=/vagrant/modules/:/etc/puppet/modules
```