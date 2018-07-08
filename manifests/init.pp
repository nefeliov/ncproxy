# Installs NINGX and includes the configuration files and
# server definitions required by the Netcentric selection test
#
# @summary Installs and configure NGNIX as required for Netcentric selection test
#
# @example
#   include ncproxy

# TODO: Add puppet NGINX module to dependencies!!
# TODO: delete default site file in sites available
# TODO: test
# TODO: improve quality (add variables, templates, etc) if enough time
class ncproxy {
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
        configs              => hiera_hash('nginx::configs', {'forward-headers.conf': 
            source => 'puppet:///modules/ncproxy/forward-headers.conf'}),
        vhosts               => hiera_hash('nginx::vhosts', {'01_reverse_proxy':
            source => 'puppet:///modules/ncproxy/01_reverse_proxy'}),
        },
  
        
        nginx::resource::config { 'proxy_log.conf':
            source => 'puppet:///modules/ncproxy/proxy_log.conf'}),
        },

        nginx::resource::vhosts { '02_forward_proxy':
            source => 'puppet:///modules/ncproxy/02_forward_proxy'}),
        },
}
