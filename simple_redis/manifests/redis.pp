# -*- mode: ruby -*-

package { 'libnss-mdns':
	ensure  => present,
}

group { 'puppet':
	ensure => present,
}

exec { 'update':
	command => '/usr/bin/apt-get update',
	path    => '/usr/local/bin/:/bin/:/usr/bin/',
}

package { 'redis-server':
	ensure  => latest,
	require => Exec['update'], 
}

service { 'redis-server':
	ensure  => running,
	require => Package['redis-server'],
}

