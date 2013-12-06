node 'base' {
	include '::ntp'
	include swuppet::common
}

node 'swiftcommon' inherits 'base' {
	include swuppet::swiftcommon
}

#
# Nodes
#

node 'keystone-01' inherits 'base' {
	include swuppet::keystone
}


node 'proxy-01' inherits 'base' {
	
}