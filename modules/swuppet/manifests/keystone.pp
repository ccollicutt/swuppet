class swuppet::keystone (
  $packages = $swuppet::params::keystone_packages
) inherits swuppet::params {

  # is this where this goes?
  #include swuppet::params

	
	package { $packages:
		ensure => installed,
	}
}