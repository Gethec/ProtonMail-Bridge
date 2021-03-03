# ProtonMail-Bridge #

## Disclaimer ##
As with anything else, exposing your system to the Internet incurs risks!  This container does its best to be as secure as possible, but makes no guarantees to being completely impenetrable.  Use at your own risk, and feel free to suggest changes that can further increase security.

## About ##
This is a personal project that I've undertaken as I have begun to explore ProtonMail.  It was inspired by shenxn's [protonmail-bridge-docker](https://github.com/shenxn/protonmail-bridge-docker), which serves the same purpose.  I encountered some issues with their container in my personal work environment, and decided to try my own hand at it.  While I leaned heavily on their project for some of the basics, I also chose to experiment and see what else I could achieve.

## Features ##
* Built on Alpine Linux for a minimal footprint
* Uses [S6-Overlay](https://github.com/just-containers/s6-overlay) for process management
* Straightforward configuration

## Configuration ##
### Volumes ###
`/root` - Storage directory for security keys and Proton-Bridge configuration files.  Required for persistence.

### Ports ###
`25/tcp` - SMTP port

`143/tcp` - IMAP port

## Setup ##
By default, the container automatically launches Proton-Bridge on start.  Since this prevents running a second instance, you have to launch the browser with a custom command to add/edit/remove accounts:

    docker run \
        -v /host/config/path:/root \
        -it gethec/protonmail-bridge
        bash

Once you have a command prompt, you can run `proton-bridge --cli` and proceed with their [documented setup process](https://protonmail.com/support/knowledge-base/bridge-cli-guide/).

## Notes ##
My specific goal with this container is to _not_ publish the ports, and instead access the container via another container over a private network.  If you wish to access the container via a device that is not on that private network, you can publish the ports by adding the following commands:

    docker run \
        -v /host/config/path:/root \
        -p 25:25 \
        -p 143:143 \
        -it gethec/protonmail-bridge
        bash


I use UnRAID as my server platform, and this container has been built with that in mind.  Once I have it working, I will probably include a conf file to make it even easier.

## Changelog ##
* 0.0.1 - Test release