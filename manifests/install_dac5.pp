class dac5::install_dac5 {
include dac5::add_users, dac5::get_dac5_rpms, dac5::install_prep, dac5::install_ruby_source, dac5::update_gems

#exec { "install_interfaces":
#        command => "/usr/gi/bin/acc_rename interfaces",
#        onlyif => "/usr/bin/test -f /usr/gi/bin/acc_rename",
#    }

#host { 'localhost':
#    ip => '127.0.0.1',
#    host_aliases => [ 'DAC', 'linuxSQL', 'SQL', 'SQL_BS', 'dacSQL_BS' ],
#}

exec { "disable_v6":
	command => '/bin/sed -i "s/install/#install/g" /etc/modprobe.d/50-ipv6.conf',
}

exec { "install_init":
	command => "/usr/bin/rpm2cpio /tmp/rpms/dac_sybase-*.rpm | /usr/bin/cpio -id ./opt/dac/dac_sybase157/sybase.init.d && /bin/mv -f ./opt/dac/dac_sybase157/sybase.init.d /opt/dac/dac_sybase/sybase.init.d >/dev/null 2>&1",
	onlyif => "/usr/bin/test -f /tmp/rpms/dac_sybase-*.rpm",
	}

package { "sybase_app-15.7-2_64.x86_64.rpm":
        ensure => installed,
        provider => 'rpm',
        source => "/tmp/rpms/sybase_app-15.7-2_64.x86_64.rpm",
        }

file { "/opt/sybase157/interfaces":
	ensure  => present,
        owner => sybase,
        group => acc4000,
        content => template('dac5/interfaces.erb'),
}

file { "/opt/sybaserep/interfaces":
	ensure  => present,
        owner => sybase,
        group => acc4000,
        content => template('dac5/interfaces.erb'),
}

#exec { "install_dac5":
#        command => "/bin/echo -ne '1\ny\nn\n' | /tmp/rpms/INSTALL",
#        onlyif => "/usr/bin/test -f /tmp/rpms/INSTALL",
#        unless => "/bin/rpm -qa | /usr/bin/grep dac_os-5 >/dev/null 2>&1",
#	logoutput => true,
#	timeout => 1500,
#	}
}
