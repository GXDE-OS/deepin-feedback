# GXDE Feedback

**Description**: Easy to use issue or advice report tool for GXDE.

GXDE Feedback will collect as much related information as possible
according to the user specified category, include machine model,
kernel version, syslog, configurations, etc. Then upload the report to
GXDE's issue tracking site and that's it.

GXDE Feedback also provide a command line tool named
`gxde-feedback-cli`, which in fact used as the information
collecting back-end. For advanced usage, run it under the terminal.

## Dependencies


## Installation

### Debian 8.0 (jessie)

Install prerequisites
```
$ sudo apt-get install dde-go-dbus-factory \
                       deepin-gettext-tools \
                       golang \
                       golang-dlib-dev \
                       qt5-default \
                       qt5-qmake \
                       qtdeclarative5-dev \
                       libqt5webkit5-dev \
                       dde-qml-dbus-factory \
                       deepin-qml-widgets \
                       efibootmgr \
                       gzip \
                       lshw \
                       qml-module-qtquick-dialogs \
                       rfkill \
                       wireless-tools \
                       libx11-dev \
                       libxtst-dev
```

Build
```
$ make GOPATH=/usr/share/gocode
```

Or, build through gccgo
```
$ make GOPATH=/usr/share/gocode USE_GCCGO=1
```

If you have isolated testing build environment (say a docker container), you can install it directly
```
$ sudo make install
```

Or, generate package files and install GXDE Feedback with it
```
$ debuild -uc -us ...
$ sudo dpkg -i ../gxde-feedback-*deb
```

## Usage

Run GXDE Feedback with the command below
```
$ gxde-feedback &
```

Collect all system information manually and save to archive file in
current directory
```
sudo gxde-feedback-cli
sudo gxde-feedback-cli all
```

Collect information without personal data
```
sudo gxde-feedback-cli --username $USER --privacy-mode
```

Only collect network related information
```
sudo gxde-feedback-cli network
```

Print current network information

```
sudo gxde-feedback-cli --dump network
```

## Getting help

Any usage issues can ask for help via

* [Gitter](https://gitter.im/orgs/linuxdeepin/rooms)
* [IRC channel](https://webchat.freenode.net/?channels=deepin)
* [Forum](https://bbs.deepin.org)
* [WiKi](http://wiki.deepin.org/)

## Getting involved

We encourage you to report issues and contribute changes

* [Contribution guide for users](http://wiki.deepin.org/index.php?title=Contribution_Guidelines_for_Users)
* [Contribution guide for developers](http://wiki.deepin.org/index.php?title=Contribution_Guidelines_for_Developers).

## License

GXDE Feedback is licensed under [GPLv3](LICENSE).
