Gentoo Zyrenth Overlay
===========================

This overlay contains a random assortment of packages used by the zyrenth webmaster.

Installation (as root)
----------------------

```
wget http://git.zyrenth.com/zyrenth-overlay.git/blob_plain/HEAD:/repositories.xml -O /etc/layman/overlays/zyrenth.xml
layman -S
layman -a zyrenth
```
