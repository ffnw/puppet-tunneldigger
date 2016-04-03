class tunneldigger (
  Integer $port_base = $tunneldigger::params::port_base,
) inherits tunneldigger::params {

  include tunneldigger::install

}

