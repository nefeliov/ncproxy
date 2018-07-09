# Installs NINGX and includes the configuration files and
# server definitions required by the Netcentric selection test
#
# @summary Installs and configure NGNIX as required for Netcentric selection test
#
# @example
#   class { 'ncproxy': }

# TODO: use nginx "configs" and "vhosts" to install files, instead of mine
# TODO: improve quality (add variables, templates, etc)
class ncproxy {
    
    $nginx_config_dir = "/etc/nginx"
    
    
    # Installs ssl-cert, needed for snakeoil certificate
    package { 'ssl-cert':
        ensure  => latest,
    }
    
   
    class{ 'nginx':
        repo_manage          => false,
        package_name         => 'nginx',
        package_extras       => [],
        service_manage       => true,
        service_enable       => true,
        service_ensure       => 'running',
        service_name         => 'nginx',
        install_location     => '/etc/nginx',
        firewall_manage      => false,
        enabled_sites_manage => false,
        configs              => hiera_hash('nginx::configs', {}),
        vhosts               => hiera_hash('nginx::vhosts', {}),
    }
    
    # Ensure default site is not enabled, as I'm managing sites from appart the
    # ntginx module
    file { "${nginx_config_dir}/sites-enabled/default":
        ensure => absent,
    }
    
    # Copy NGINX config files
    file { "${nginx_config_dir}/conf.d/forward-headers.conf":
        mode    => '644',
        owner   => 'root',
        group   => 'root',
        ensure   => present,
        source  => "puppet:///modules/ncproxy/forward-headers.conf",
        notify  => Service['nginx'],
    }
    file { "${nginx_config_dir}/conf.d/proxy_log.conf":
        mode    => '644',
        owner   => 'root',
        group   => 'root',
        ensure   => present,
        source  => "puppet:///modules/ncproxy/proxy_log.conf",
        notify  => Service['nginx'],
    }
    # Copy NGINX sites definitions (aka virtial hosts)
    file { "${nginx_config_dir}/sites-available/01_reverse_proxy":
        mode    => '644',
        owner   => 'root',
        group   => 'root',
        ensure   => present,
        source  => "puppet:///modules/ncproxy/01_reverse_proxy",
        notify  => Service['nginx'],
    }
    file { "${nginx_config_dir}/sites-available/02_forward_proxy":
        mode    => '644',
        owner   => 'root',
        group   => 'root',
        ensure   => present,
        source  => "puppet:///modules/ncproxy/02_forward_proxy",
        notify  => Service['nginx'],
    }
    
    # Enable servers
    file { "${nginx_config_dir}/sites-enabled/01_reverse_proxy":
        ensure   => link,
        target   => "${nginx_config_dir}/sites-available/01_reverse_proxy",
    }
    file { "${nginx_config_dir}/sites-enabled/02_forward_proxy":
        ensure   => link,
        target   => "${nginx_config_dir}/sites-available/02_forward_proxy",
    }

}
