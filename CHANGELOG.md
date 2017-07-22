Drone Cookbook Changelog
=========================

v6.0.0
------
* **BREAKING**: Does not support versions of Drone older then 0.8.0 now.
* **BREAKING**: `recipe[drone::default]` renamed to `recipe[drone::server]`
* **BREAKING**: Does not manage docker install by default anymore.  New *standalone* recipes
included for that functionality now.
* **BREAKING**: `node['drone']['repo']` seperated for agent (`node['drone']['agent']['repo']`) and server (`node['drone']['server']['repo']`).
* **BREAKING**: Probably other breaking changes.  Be sure to test this in a new environment.
* Supports Drone 0.8.0

v5.2.0
------
* Allow specifying `bip` for docker service

v5.1.1
------
* Properly load defined storage driver by restarting Docker if currently not loaded

v5.1.0
------
* Parameterize volumes for agent

v5.0.0
------
* **BREAKING**: The behavior of `node['drone']['server']['port']` has changed slightly.
Before it was the host port to NAT to the container port.  Now it is the port
value to pass to `docker_container('drone')` directly.
* Added ability to set `network_mode` for server and agent.  Default will remain `bridge`.

v4.1.0
------
* Attributize items to load from vault

v4.0.3
------
* Allow using `drone_database_config` as a secret

v4.0.2
------
* Allow using `drone_database_config` as a secret

v4.0.1
------
* Remove `chef_nginx` and `ssl_certificate` cookbook dependencies.

v4.0.0
------
* **BREAKING**: Remove support for Drone 0.4
* **BREAKING**: Remove support for old platforms (Ubuntu 14.x, Centos 6.x)
  * This allows control docker version on RHEL platforms too now!
  * May actually still work on older platforms, just not testing for it anymore.
* **BREAKING**: Remove support for reverse proxy
  * Can still [configure HTTPS](README.md#https-config)
* **BREAKING**: Remove SSL cert generation for docker
* **BREAKING**: Move `node['drone']['config']` -> `node['drone']['server']['config']`
* Install docker via packages

v3.6.1
------
* Updates to work properly in Chef 13

v3.6.0
------
* Allow specifying volumes to mount into Drone from host with `node['drone']['server']['volumes']`
* Minor Breaking: specifying host port to bind Drone to with `node['drone']['server']['port']`
  * Decided to do this since 3.5.0 has been released for 30min now and this makes more sense and don't wanna major version bump.  Sorry!

v3.5.0
------
* Allow specifying host port to bind Drone to with `node['drone']['port']`

v3.4.0
------
* Allow setting drone container to use with `node['drone']['repo']`.  Default is `drone/drone` which is what was previously hardcoded.

v3.3.0
------
* Allow setting node attributes `node['drone']['repo_activation_org_whitelist']` to whitelist orgs for repo activation when `node['drone']['disable_repo_activation']` is set to `true`

v3.2.0
------
* Allow setting node attribute `node['drone']['disable_repo_activation']` to disable ability to activate new repos

v3.1.3
------
* Update to work with Drone 0.5 new server <> agent commication protocol
 * http://readme.drone.io/0.5/installation/agents

v3.1.2
------
* For newer version of Docker need to use new resource in docker cookbook for installing while specifying a version

v3.1.1
------
* Fix reverse proxy for Drone 0.5

v3.1.0
------
* Add ability to set docker daemon logging level

v3.0.2
------
* Allow bypassing loading secrets on chef-vault failure (permissions)

v3.0.1
------
* Fix allowing user to specify docker version

v3.0.0
------
* BREAKING CHANGE (maybe): No longer pin version of docker to install by default.
You still can do it if you want manually though.

v2.5.0
------
* Support for CentOS 7.x

v2.4.0
------
* Remove DEPRECATED drone token secrets management items
* Added drone_secret support

v2.3.0
------
* Allow drone_github_client to be in a Vault

v2.2.0
------
* Attributize logging for Drone containers

v2.1.0
------
* Allow specifying version of drone to use
* Added `drone::agent` recipe for installing Drone 0.5 agent
* Added ability to apply secrets `drone_agent_secret`, `drone_token`, `drone_github_secret` and `database_config` from vault

v2.0.0
------
* BREAKING CHANGE: Move Drone app config items to `node['drone']['config']`
* BREAKING CHANGE: Removed package install method as it's not supported
* Added `drone::reverse_proxy` recipe to be able to front Drone with HTTPS via a reverse proxy
* Added `drone::worker` recipe to be able to create additional systems to run drone builds on
* Version bump on docker community cookbook
* Make `docker_container` resource sensitive to prevent displaying secrets passed through ENV to drone

v1.0.0
------
* BREAKING CHANGE: Use drone containers rather then installing drone package by default
* Add ability to deploy drone using drone docker container

v0.7.7
------
* Uses docker version from attributes (default 1.8.3)
* Specify docker tls certs or use self-generated

v0.7.0
------
* Deploy Drone v0.4.0 (a dev branch)
* Add dronerc template
* Add docker recipe to install docker from cookbook
* Add update recipe to update docker images
* For integrations generates docker self-signed certs

v0.6.0
------
* Docker can now be disabled (Graham Weldon)
* Fix `registration` option - moving to each VCS config (Graham Weldon)
* Extend / improve README documentation

v0.5.0
------
* Configure Drone with TOML (Graham Weldon)
* Use new Drone package URL (Ke Zhu)

v0.4.0
------

* Add Apache 2.0 license
* Fix options being passed to droned (Ross Timson)
* Numerous development/test improvements (Ross Timson)

v0.3.1
------

* Settable drone_tmp (Eric Buth)

v0.2.0
------

* Add ability to specify custom drone options (Brint O'Hearn)

v0.1.0
------

* Initial Drone cookbook (Justin Campbell)
