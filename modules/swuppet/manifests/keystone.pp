class swuppet::keystone {
	
	$keystone_packages = [ 'keystone', 'python-keyring', 'mysql-server', 'python-mysqldb']

	package { $keystone_packages:
		ensure => installed,
	}
}