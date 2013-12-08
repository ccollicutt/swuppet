class swuppet::common (
  $packages = $swuppet::params::common_packages 
  ) inherits swuppet::params {

  # is this where this goes?
  #include swuppet::params


  exec { 'apt-get update':
    command => '/usr/bin/apt-get update',
    onlyif  => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || \
    /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | \
    /bin/grep . > /dev/null'",
  }

  package { $packages:
    ensure  => installed,
    require => Exec['apt-get update'],
  }

  apt::source { 'ubuntu-cloud-havana':
    location          => 'http://ubuntu-cloud.archive.canonical.com/ubuntu',
    release           => 'precise-updates/havana',
    repos             => 'main',
    required_packages => 'ubuntu-cloud-keyring',
    include_src       => false,
    before            => Exec['apt-get update']
  }
}