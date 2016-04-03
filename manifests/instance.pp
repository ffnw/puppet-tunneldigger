define tunneldigger::instance (
  String           $address            = '0.0.0.0',
  Variant[Integer,
    String,Array]  $port               = [ 53, 123, 8942 ],
  String           $interface          = 'eth0',
  Integer          $max_tunnels        = 1000,
  Integer          $tunnel_id_base     = 0,
  String           $namespace          = "${title}",
  Boolean          $check_modules      = true,
  String           $filename           = "/var/log/tunneldigger-${title}.log",
  Enum['DEBUG']    $verbosity          = 'DEBUG',
  Boolean          $log_ip_addresses   = false,
  String           $session_up         = epp('tunneldigger/setup_interface.sh.epp'),
  String           $session_predown    = '',
  String           $session_down       = epp('tunneldigger/teardown_interface.sh.epp'),
  String           $session_mtuchanged = epp('tunneldigger/mtu_changed.sh.epp'),
) {

  include tunneldigger
  include tunneldigger::params

  file {
    default:
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0744';
    "/etc/tunneldigger/${title}/session-up.sh":
      content => $session_up;
    "/etc/tunneldigger/${title}/session-predown.sh":
      content => $session_predown;
    "/etc/tunneldigger/${title}/session-down.sh":
      content => $session_down;
    "/etc/tunneldigger/${title}/session-mtuchanged.sh":
      content => $session_mtuchanged;
    "/etc/tunneldigger/${title}/broker.cfg":
      mode    => '0644',
      content => epp('tunneldigger/broker.cfg.epp', {
        address            => $address,
        port               => $port,
        interface          => $interface,
        max_tunnels        => $max_tunnels,
        port_base          => $tunneldigger::port_base,
        tunnel_id_base     => $tunnel_id_base,
        namespace          => $namespace,
        check_modules      => $check_modules,
        filename           => $filename,
        verbosity          => $verbosity,
        log_ip_addresses   => $log_ip_addresses,
        session_up         => "/etc/tunneldigger/${title}/session-up.sh",
        session_predown    => "/etc/tunneldigger/${title}/session-predown.sh",
        session_down       => "/etc/tunneldigger/${title}/session-down.sh",
        session_mtuchanged => "/etc/tunneldigger/${title}/session-mtuchanged.sh",
      });
  } ~>
  service { "tunneldigger@${title}":
    ensure => running,
    enable => true,
  }

}

