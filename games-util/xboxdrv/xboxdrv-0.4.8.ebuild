# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit linux-mod eutils

MY_P=${PN}-linux-${PV}
DESCRIPTION="Xbox/Xbox360 gamepad driver for Linux that works in userspace"
HOMEPAGE="http://pingus.seul.org/~grumbel/xboxdrv/"
SRC_URI="http://pingus.seul.org/~grumbel/xboxdrv/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-util/scons
	dev-libs/boost
	virtual/libusb
	dev-python/dbus-python"

CONFIG_CHECK="INPUT_JOYDEV INPUT_UINPUT"

src_unpack() {
    unpack ${A}
    cd "${S}"
    epatch "${FILESDIR}/gcc44.patch"
}

src_compile() {
        scons ${MAKEOPTS} || die "scons make died"
}

src_install() {
	dosbin xboxdrv

	insinto /etc/hal/fdi/policy
	newins hal/xboxdrv_policy.fdi 99-xboxdrv.fdi

	insinto /etc/hal/fdi/preprobe
	newins hal/xboxdrv_preprobe.fdi 99-xboxdrv.fdi

	dodoc README NEWS AUTHORS PROTOCOL
}

pkg_postinst() {
	einfo "Please read the README file to find how to use the driver"
}
