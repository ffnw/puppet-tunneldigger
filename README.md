# puppet-tunneldigger

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with tunneldigger](#setup)
    * [What tunneldigger affects](#what-tunneldigger-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with tunneldigger](#beginning-with-tunneldigger)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module installs and manages tunneldigger server instances.

Tunneldigger is a simple VPN Tunnel Broker for L2TPv3 tunnels.

## Setup

### Beginning with tunneldigger

```puppet
tunneldigger::interface { 'backbone':
  address => '0.0.0.0',
}
```

## Usage

```puppet
class { 'tunneldigger':
  port_base => 20000,
}

tunneldigger::interface { 'backbone':
  address            => '0.0.0.0',
  port               => [ 53, 123, 8942 ],
  interface          => 'eth0',
  max_tunnels        => 1000,
  tunnel_id_base     => 0,
  namespace          => "${title}",
  check_modules      => true,
  max_cookies        => $max_tunnels,
  tunnel_timeout     => 60,
  pmtu_discovery     => true,
  filename           => "/var/log/tunneldigger-${title}.log",
  verbosity          => 'DEBUG',
  log_ip_addresses   => false,
  session_up         => epp('tunneldigger/setup_interface.sh.epp'),
  session_predown    => epp('tunneldigger/donothing.sh.epp'),
  session_down       => epp('tunneldigger/teardown_interface.sh.epp'),
  session_mtuchanged => epp('tunneldigger/mtu_changed.sh.epp'),
}
```

## Reference

* class tunneldigger
  * port_base (optional, default 20000)

* define tunneldigger::interface
  * address (optional, default '0.0.0.0')
  * port (optional, default [ 53, 123, 8942 ])
  * interface (optional, default 'eth0')
  * max\_tunnels (optional, default 1000)
  * tunnel\_id\_base (optional, default 0)
  * namespace (optional, default "${title}")
  * check\_modules (optional, default true)
  * max\_cookies (optional, default $max\_tunnels)
  * tunnel\_timeout (optional, default 60)
  * pmtu\_discovery (optional, default true)
  * filename (optional, default "/var/log/tunneldigger-${title}.log")
  * verbosity (optional, default 'DEBUG')
  * log\_ip\_addresses (optional, default false)
  * session\_up (optional, default see [templates/setup_interface.sh.epp])
  * session\_predown (optional, default '')
  * session\_down (optional, default see [templates/teardown_interface.sh.epp])
  * session\_mtuchanged (optional, default see [templates/mtu_changed.sh.epp])

## Limitations

### OS compatibility
* Debian 8

## Development

### How to contribute
Fork the project, work on it and submit pull requests, please.

