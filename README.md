
# ncproxy

#### Table of Contents

1. [Description](#description)
2. [Setup](#setup)
    * [Files created by the module](#Files-created-by-the-module)
    * [Setup requirements](#setup-requirements)
3. [Usage](#usage)
4. [Limitations](#limitations)

## Description

This NGINX proxy module installs NGINX and add the following configuration:

* A reverse proxy for domain.com, redirecting everything to 10.10.10.10 but requests to resource2, redirected to 20.20.20.20. It adds the RFC 7239 Forwarded header to the backend servers, as well as the tradition X-forwarded-for.
* A forward HTTP proxy with the sole objetive to log petitions. The log format includes request protocol, remote IP and time taken to serve the request.


## Setup

### Files created by the module

This module creates the following configuration files in NGINX conf.d directory:

* forward-headers.conf: contains instructions to create the Forwarded header (RFC7239).
* proxy_log.conf: log format definition for the forward proxy.

The following files in NGINX sites-available directory:

* 01_reverse_proxy
* 02_forward_proxy

And corresponding symlinks in the sites-enabled directory.

### Setup Requirements

This module depends on the [rehan-nginx](https://forge.puppet.com/rehan/nginx) version 2.0.2, so it should be installed prior using this module. So please, use the folling command to install it:

```puppet module install rehan-nginx --version 2.0.2```

This module is not avaiable in puppet forge, so you should download it from github and install it manually in your modules directory corresponding to your environment.

## Usage

As this module does not accept parameters, the usage is quite easy. Just add this to your manifest:

```class { 'ncproxy': }```

and you will have it running.

## Limitations

* It doesn't use config parameters.
* This module only works with Debian based Linux distribution.