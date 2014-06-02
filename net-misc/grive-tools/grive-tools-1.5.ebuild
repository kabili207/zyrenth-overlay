# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Google Drive Client with Grive and Grive Tools"
HOMEPAGE="https://launchpad.net/~thefanclub/+archive/grive-tools"
SRC_URI="https://launchpad.net/~thefanclub/+archive/grive-tools/+files/${PN}_${PV}.tar.gz -> ${P}.tgz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="
    net-misc/grive
    x11-libs/libnotify
    dev-libs/libappindicator
    dev-python/pyinotify
    gnome-extra/zenity
    x11-libs/gksu
    dev-tcltk/expect
    >=dev-libs/json-c-0.10
    >=dev-libs/yajl-2
    dev-libs/libgcrypt
    dev-libs/boost
    dev-libs/expat
    sys-devel/binutils
    sys-libs/glibc
    sys-libs/zlib
    "

DEPEND="${RDEPEND}"

src_install()
{
    dodir /opt
    cp -R "${S}/grive-tools/opt/" "${D}/opt/" || die "Install failed!"

    dodir /usr
    cp -R "${S}/grive-tools/usr/" "${D}/usr/" || die "Install failed!"

}
