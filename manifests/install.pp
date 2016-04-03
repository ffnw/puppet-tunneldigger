class tunneldigger::install inherits tunneldigger {

  class { 'python' :
    version    => 'system',
    pip        => 'present',
    dev        => 'present',
    virtualenv => 'present',
    gunicorn   => 'absent',
  } ->
  package {
    default:
      ensure => latest;
    'iproute':;
    'bridge-utils':;
    'libnetfilter-conntrack3':;
    'libevent-dev':;
    'ebtables':;
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
  } ~>
  exec { 'tunneldigger-daemon-reload':
    command => 'systemctl daemon-reload',
  } ->
  vcsrepo { '/srv/tunneldigger/tunneldigger':
    ensure   => latest,
    provider => git,
    source   => 'https://github.com/wlanslovenija/tunneldigger.git',
    revision => 'master',
  } ->
  python::virtualenv { '/srv/tunneldigger/env_tunneldigger':
    requirements => '/srv/tunneldigger/tunneldigger/broker/requirements.txt',
    owner        => 'root',
    group        => 'root',
  }

}

