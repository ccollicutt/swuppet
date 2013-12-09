class swuppet::keystone (
  $packages = $swuppet::params::keystone_packages,
  $keystone_db_password = undef,
  $keystone_admin_token = undef,
) inherits swuppet::params {

	package { $packages:
		ensure => installed,
	}

	# 
	# File defaults
	#

   File {
     mode  => '0640',
     owner => 'keystone',
     group => 'keystone',
   }

	# remove defualt keystone sqlite database file
	file { '/var/lib/keystone/keystone.db':
		ensure => absent,
	}

	file { '/etc/keystone/keystone.conf':
	  notify  => Service['keystone'],
		content => template('swuppet/keystone.conf.erb'),
	}

	#
	# Setup SSL
	# 

	exec { 'setup ssl':
		command => '/usr/bin/keystone-manage ssl_setup --keystone-user keystone --keystone-group keystone',
		creates => '/etc/keystone/ssl/certs/keystone.pem',
	}

	#
	# Mysql!
	#

  # NOTE: This didn't seem to work...only created the database, may be using it incorrectly
	#mysql::db { 'keystone':
	#	user     => 'keystone',
	#	password => "${keystone_db_password}",
	#	host     => 'localhost',
	#	grant    => [ 'ALL' ],
	#}

	# XXX not sure mysql-client is required XXX
	# XXX FIX ME - password hash can be done with mysql_password
	mysql_user { 'keystone@localhost':
    ensure         => present,
    password_hash  => '*BFC9CAA3DC41025E1EF2F061A7FDC975759B0516',
    require        => Package[mysql-client],
  }

  mysql_database {'keystone':
  	ensure => 'present',
  }

  mysql_grant { 'keystone@localhost/keystone':
  	ensure     => 'present',
  	options    => ['GRANT'],
  	privileges => ['ALL'],
  	table      => '*.*',
  	user       => 'keystone@localhost',
  }

  #
  # Keystone service
  # 

  service { 'keystone':
  	ensure  => running,
  	subscribe => File['/etc/keystone/keystone.conf'],
  	require => [
  								File['/etc/keystone/keystone.conf'],
  								Exec['setup ssl'],
  								Mysql_database['keystone'],
  							]
  }



}