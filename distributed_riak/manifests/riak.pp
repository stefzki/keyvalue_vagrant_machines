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

package { 'libssl0.9.8':
	ensure => present,
	require => Exec['update'], 
}

exec { 'wget':
	command => 'wget -O /vagrant/riak.deb http://downloads.basho.com.s3-website-us-east-1.amazonaws.com/riak/CURRENT/ubuntu/precise/riak_1.2.1-1_amd64.deb',
	path    => '/usr/local/bin/:/bin/:/usr/bin/',
	creates => '/vagrant/riak.deb', 	
	require => Package['libssl0.9.8'],
}

exec { 'install':
	command => 'dpkg -i /vagrant/riak.deb',
	path    => '/usr/local/bin/:/bin/:/usr/bin/:/usr/sbin/:/sbin/',
	creates => '/etc/init.d/riak', 	
	require => Exec['wget'],
}

file {"/etc/riak/vm.args":
	content => template("/vagrant/manifests/vm.erb"),
	require => Exec["install"],
}

file {"/etc/riak/app.config":
	content => template("/vagrant/manifests/app.erb"),
	require => Exec["install"],
}

file {"/etc/riak/cert.pem":
	source => "/vagrant/manifests/cert.pem",
	require => Exec["install"],
}

file {"/etc/riak/key.pem":
	source => "/vagrant/manifests/key.pem",
	require => Exec["install"],
}

exec { 'allNetworks':
	command => 'sed -i "s/127.0.0.1/0.0.0.0/" /etc/riak/app.config',
	path    => '/usr/local/bin/:/bin/:/usr/bin/:/usr/sbin/:/sbin/',
	require => Exec['install'],
}

exec { 'startriak':
	command => '/etc/init.d/riak start',
	path    => '/usr/local/bin/:/bin/:/usr/bin/:/usr/sbin/:/sbin/',
	require => [Exec['allNetworks'], File['/etc/riak/app.config', '/etc/riak/vm.args', '/etc/riak/key.pem', '/etc/riak/cert.pem']],
}

#whyever this is not working
service { 'riak':
	ensure  => 'running',
	require => Exec['install'],
}

