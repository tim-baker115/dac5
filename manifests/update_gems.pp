class dac5::update_gems {
include dac5::add_users, dac5::get_dac5_rpms, dac5::install_prep, dac5::install_ruby_source

exec { "update_rdoc":
        command => "/usr/bin/gem install --force rdoc && /usr/bin/gem rdoc --all --overwrite",
	#Regex to make sure the version is greater than 4.1.X
        unless => "/usr/bin/rdoc --version | grep -q 4.[1-9].[0-9]",
	timeout => 1500,
    }

exec { "update_rake":
	command => "/usr/bin/gem install --force rake",
	#Regex to make sure the version is greater than 10.X.X
	unless => "/usr/bin/rake --version | awk '{print $3}' | grep -q 10.[0-9].[0-9]",
	timeout => 1500,
    }

exec { "gem_update":
        command => "/usr/bin/gem update",
	timeout => 1500,
	require => Exec['gem_install_rails'],
	creates => "/usr/bin/rails",
    }

exec { "gem_install_rails":
	command => "/usr/bin/gem install rails",
	creates => "/usr/bin/rails",
	timeout => 1500,
    }

}
