node 'base' {
	include '::ntp'
	include swuppet::common
}

node 'swiftcommon' inherits 'base' {
	include swuppet::swiftcommon
}

node 'keystone-01' inherits 'base' {
	
}