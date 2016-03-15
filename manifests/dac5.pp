class dac5 {
if $operatingsystem != 'SLES' {
        fail('Must be run on SLES, exiting.')
}
else {
        notice('The system requires the following attributes.')
        notice('Memory: 4GB or greater')
        notice('Processor: X86 64')
        notice('Disk space: 10GB free')
	include dac5::add_users, dac5::get_dac5_rpms, dac5::install_prep, dac5::install_ruby_source, dac5::update_gems, dac5::install_dac5
	Class['dac5::add_users'] -> Class['dac5::get_dac5_rpms'] -> Class['dac5::install_prep'] -> Class['dac5::install_ruby_source'] -> Class['dac5::update_gems'] -> Class['dac5::install_dac5']
}

}
