node 'base' {
	include '::ntp'
	#include swuppet::common
}

node 'swiftcommon' inherits 'base' {
	include swupper::swiftcommon
}

node 'keystone-01' inherits 'base' {
	
}