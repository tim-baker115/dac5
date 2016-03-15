class dac5::install_prep {
include dac5::add_users, dac5::get_dac5_rpms, dac5::install_prep
file { "/gi":
        path => "/gi",
        ensure => directory,
        }

file { "/data":
        path => "/data",
        ensure => directory,
        }

file { "/opt/dac":
        path => "/opt/dac",
	owner => "acc4000d",
	group => "acc4000",
        ensure => directory,
        }

file { "/home/acc4000d/data":
        path => "/home/acc4000d/data",
	owner => "acc4000d",
	group => "acc4000",
        ensure => directory,
        }

file { "/opt/dac/dac_sybase":
        path => "/opt/dac/dac_sybase",
        ensure => directory,
        }

file { "/opt/sybaserep":
        path => "/opt/sybaserep",
        ensure => directory,
        }

file { "/opt/dac/dac_sybase157":
        path => "/opt/dac/dac_sybase157",
        ensure => directory,
        }

#file { "/opt/sybase157/interfaces":
#        owner => sybase,
#        group => acc4000,
#        content => template('dac5/interfaces.erb'),
#}

#file { "/opt/sybaserep/interfaces":
#        owner => sybase,
#        group => acc4000,
#        content => template('dac5/interfaces.erb'),
#}

#file { "/opt/dac/dac_sybase/dwsp":
#        target => "/opt/dac/dac_sybase157/dwsp",
#	ensure => 'link',
#        }

package { "linux-kernel-headers-2.6.32-1.4.13.noarch":
        ensure => installed,
        provider => 'rpm',
        source => "/tmp/rpms/linux-kernel-headers-2.6.32-1.4.13.noarch.rpm",
        }

package { "glibc-devel-2.11.1-0.17.4.x86_64":
        ensure => installed,
        provider => 'rpm',
        source => "/tmp/rpms/glibc-devel-2.11.1-0.17.4.x86_64.rpm",
        require => Package["linux-kernel-headers-2.6.32-1.4.13.noarch"],
        }

package { "gcc43-4.3.4_20091019-0.7.35.x86_64":
        ensure => installed,
        provider => 'rpm',
        source => "/tmp/rpms/gcc43-4.3.4_20091019-0.7.35.x86_64.rpm",
        require => Package["glibc-devel-2.11.1-0.17.4.x86_64"],
	}

package { "gcc-4.3-62.198.x86_64":
        ensure => installed,
        provider => 'rpm',
        source => "/tmp/rpms/gcc-4.3-62.198.x86_64.rpm",
        require => Package["glibc-devel-2.11.1-0.17.4.x86_64"],
	}

package { "unixODBC-2.2.12-198.17.x86_64":
        ensure => installed,
        provider => 'rpm',
        source => "/tmp/rpms/unixODBC-2.2.12-198.17.x86_64.rpm",
        require => Package["gcc-4.3-62.198.x86_64"],
        }

package { "openmotif-2.3.2-1":
        ensure => installed,
        provider => 'rpm',
        source => "/tmp/rpms/openmotif-2.3.2-1.suse11.1.x86_64.rpm",
        require => Package["unixODBC-2.2.12-198.17.x86_64"],
        }

package { "libopenssl0_9_8-0.9.8j-0.38.1.x86_64":
        ensure => installed,
        provider => 'rpm',
	install_options => ['-U'],
        source => "/tmp/rpms/libopenssl0_9_8-0.9.8j-0.38.1.x86_64.rpm",
        }

package { "zlib-devel-1.2.3-106.34.x86_64":
        ensure => installed,
        provider => 'rpm',
        source => "/tmp/rpms/zlib-devel-1.2.3-106.34.x86_64.rpm",
        require => Package["libopenssl0_9_8-0.9.8j-0.38.1.x86_64"],
        }

package { "libopenssl-devel-0.9.8j-0.24.1.x86_64":
        ensure => installed,
        provider => 'rpm',
        source => "/tmp/rpms/libopenssl-devel-0.9.8j-0.24.1.x86_64.rpm",
        require => Package["zlib-devel-1.2.3-106.34.x86_64"],
        }

#exec { "set_hostname":
#        command => "/bin/hostname dac && /bin/echo dac > /etc/HOSTNAME",
#	unless => "/bin/hostname | /usr/bin/grep -q dac",
#	}

#host { 'localhost':
#    ip => '127.0.0.1',
#    host_aliases => [ 'dac' ],
#}

}
