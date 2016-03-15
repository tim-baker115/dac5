class dac5::add_users {
include dac5::add_users
user { "fldendr":
    ensure => present,
    gid => 'acc4000',
    managehome => true,
    groups => ["acc4000", "video", "dialout"],
    password => '$1$szxsKziL$2I/sXeABkfA4MvwZj76rb1',
}

user { "acc4000d":
    ensure => present,
    gid => 'acc4000',
    managehome => true,
    groups => ["acc4000", "video", "dialout"],
    password => '$1$szxsKziL$2I/sXeABkfA4MvwZj76rb1',
}

user { "sybase":
    ensure => present,
    gid => 'acc4000',
    managehome => true,
    groups => ["acc4000", "video", "dialout"],
    password => '$1$szxsKziL$2I/sXeABkfA4MvwZj76rb1',
}

user { "sybaserep":
    ensure => present,
    gid => 'acc4000',
    managehome => true,
    groups => ["acc4000", "video", "dialout"],
    password => '$1$szxsKziL$2I/sXeABkfA4MvwZj76rb1',
}

group { "acc4000":
    ensure => present,
}

group { "video":
    ensure => present,
}

group { "dialout":
    ensure => present,
}

}
