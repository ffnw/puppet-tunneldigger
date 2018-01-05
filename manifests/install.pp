class tunneldigger::install inherits tunneldigger {

  if !defined(Package['git']) {
    package { 'git':
      ensure => installed,
    }
  }

  package {
    default:
      ensure => latest;
    'iproute':;
    'bridge-utils':;
    'libnetfilter-conntrack-dev':;
    'libnfnetlink-dev':;
    'libffi-dev':;
    'python-dev':;
    'libevent-dev':;
    'ebtables':;
  } ->
  file_line { 'tunneldigger l2tp_core module':
    path => '/etc/modules',
    line => 'l2tp_core',
  } ->
  file_line { 'tunneldigger l2tp_eth module':
    path => '/etc/modules',
    line => 'l2tp_eth',
  } ->
  file_line { 'tunneldigger l2tp_netlink module':
    path => '/etc/modules',
    line => 'l2tp_netlink',
  } ->
  file {
    default:
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0755';
    '/srv/tunneldigger':;
    '/etc/tunneldigger':;
  } ->
  file { '/srv/tunneldigger/setup.sh':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0744',
    source => 'puppet:///modules/tunneldigger/setup.sh',
  } ->
  file { '/srv/tunneldigger/start.sh':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0744',
    source => 'puppet:///modules/tunneldigger/start.sh',
  } ->
  file { '/etc/systemd/system/tunneldigger@.service':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/tunneldigger/tunneldigger@.service',
  } ->
  vcsrepo { '/srv/tunneldigger/tunneldigger':
    ensure   => latest,
    provider => git,
    source   => 'https://github.com/wlanslovenija/tunneldigger.git',
    revision => 'master',
  } ~>
  exec { 'Setup Tunneldigger':
    command => '/srv/tunneldigger/setup.sh',
    cwd     => '/srv/tunneldigger',
    user    => 'root',
  }

}

