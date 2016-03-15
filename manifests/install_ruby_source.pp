class dac5::install_ruby_source {
include dac5::add_users, dac5::get_dac5_rpms, dac5::install_prep

exec { "extract_ruby_tar":
        command => "/bin/tar -xzf /tmp/rpms/ruby-2.0.0-p598.tar.gz -C /tmp/rpms/",
        onlyif => "/usr/bin/test -f /tmp/rpms/ruby-2.0.0-p598.tar.gz",
	unless => "/usr/bin/ruby --version | /usr/bin/awk '{print $2}' | grep -q 2.[0-9].[0-9]",
	creates => "/tmp/rpms/ruby-2.0.0-p598"
    }

exec { "configure_ruby":
	command => "/tmp/rpms/ruby-2.0.0-p598/configure --with-openssl-dir=/usr --prefix=/usr --disable-pthread",
	require => Exec['extract_ruby_tar'],
	unless => "/usr/bin/ruby --version | /usr/bin/awk '{print $2}' | grep -q 2.[0-9].[0-9]",
	timeout => 1500,
	creates => "/tmp/rpms/ruby-2.0.0-p598/Makefile",
    }

exec { "make_ruby":
	command => "/usr/bin/make /tmp/rpms/ruby-2.0.0-p598",
    	require => Exec['configure_ruby'],
	unless => "/usr/bin/ruby --version | /usr/bin/awk '{print $2}' | grep -q 2.[0-9].[0-9]",
	#logoutput => true,
	timeout => 1500,
    }

exec { "install_ruby":
        command => "/usr/bin/make install /tmp/rpms/ruby-2.0.0-p598",
    	require => Exec['make_ruby'],
	#unless => "/usr/bin/ruby --version | /usr/bin/awk '{ print $2 }' | grep -q -o -E '^([2-9].[0-9].[0-9])*'",
	unless => "/usr/bin/ruby --version | /usr/bin/awk '{print $2}' | grep -q 2.[0-9].[0-9]",
	#logoutput => true,
	timeout => 1500,
	}
}
