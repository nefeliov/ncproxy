# Installs NINGX and includes the configuration files and
# server definitions required by the Netcentric selection test
#
# @summary Installs and configure NGNIX as required for Netcentric selection test
#
# @example
#   include ncproxy

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
        configs              => hiera_hash('nginx::configs', {}),
        vhosts               => hiera_hash('nginx::vhosts', {}),
    }
    
    # TODO: As I'm not sure if enabled_sites_manage will purge all sites enabled 
    # and recreate symlinks on each puppet invocation if all information is not 
    # included in the hiera_hash in the nginx class invokation, so I preferred
    # set it to false and ensure default site is deleted here
    file { '/etc/nginx/sites-enabled/default':
        ensure => absent,
    }
    
    nginx::resource::config { 'proxy_log.conf':
        source => 'puppet:///modules/ncproxy/proxy_log.conf',
    }

    nginx::resource::config { 'forward-headers.conf':
        source => 'puppet:///modules/ncproxy/forward-headers.conf',
    }

    nginx::resource::vhosts { '01_reverse_proxy':
        enabled => true,
        source => 'puppet:///modules/ncproxy/01_reverse_proxy',
    }

    nginx::resource::vhosts { '02_forward_proxy':
        enabled => true,
        source => 'puppet:///modules/ncproxy/02_forward_proxy',
    }
        
}
