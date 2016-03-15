class dac5::get_dac5_rpms {
include dac5::add_users, dac5::get_dac5_rpms
file { "/tmp/rpms":
        path => "/tmp/rpms",
        ensure => directory,
        source => "puppet:///dac5/dac5/",
        recurse => true,
        }
}

