
# ncproxy

#### Table of Contents

1. [Description](#description)
2. [Setup](#setup)
    * [Files created by the module](#Files-created-by-the-module)
    * [Setup requirements](#setup-requirements)
    * [Beginning with ncproxy](#beginning-with-ncproxy)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations](#limitations)

## Description

This NGINX proxy module installs NGINX and add the following configuration:

* A reverse proxy for domain.com, redirecting everything to 10.10.10.10 but requests to resource2, redirected to 20.20.20.20. It adds the RFC 7239 Forwarded header to the backend servers, as well as the tradition X-forwarded-for.
* A forward HTTP proxy with the sole objetive to log petitions. The log format includes request protocol, remote IP and time taken to serve the request.


## Setup

### Files created by the module

This module creates the following configuration files in NGINX conf.d directory:
    
    * forward-headers.conf: contains instructions to create the Forwarded header (RFC7239).
    * proxy_log.conf: log format definition for the forward proxy.`

### Setup Requirements

This module depends on the [rehan-nginx](https://forge.puppet.com/rehan/nginx) version 2.0.2, so it should be installed prior using this module.

### Beginning with ncproxy

The very basic steps needed for a user to get the module up and running. This can include setup steps, if necessary, or it can be an example of the most basic use of the module.

## Usage

Include usage examples for common use cases in the **Usage** section. Show your users how to use your module to solve problems, and be sure to include code examples. Include three to five examples of the most important or common tasks a user can accomplish with your module. Show users how to accomplish more complex tasks that involve different types, classes, and functions working in tandem.

## Reference

This section is deprecated. Instead, add reference information to your code as Puppet Strings comments, and then use Strings to generate a REFERENCE.md in your module. For details on how to add code comments and generate documentation with Strings, see the Puppet Strings [documentation](https://puppet.com/docs/puppet/latest/puppet_strings.html) and [style guide](https://puppet.com/docs/puppet/latest/puppet_strings_style.html)

If you aren't ready to use Strings yet, manually create a REFERENCE.md in the root of your module directory and list out each of your module's classes, defined types, facts, functions, Puppet tasks, task plans, and resource types and providers, along with the parameters for each.

For each element (class, defined type, function, and so on), list:

  * The data type, if applicable.
  * A description of what the element does.
  * Valid values, if the data type doesn't make it obvious.
  * Default value, if any.

For example:

```
### `pet::cat`

#### Parameters

##### `meow`

Enables vocalization in your cat. Valid options: 'string'.

Default: 'medium-loud'.
```

## Limitations

Currently this module only works with Debian based Linux distribution.
