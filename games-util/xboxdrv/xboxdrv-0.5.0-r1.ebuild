# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/xboxdrv/xboxdrv-0.5.0.ebuild,v 1.3 2010/07/16 09:57:13 fauli Exp $

EAPI=2
inherit eutils toolchain-funcs linux-info

MY_P=${PN}-linux-${PV}
DESCRIPTION="Userspace Xbox 360 Controller driver"
HOMEPAGE="http://pingus.seul.org/~grumbel/xboxdrv/"
SRC_URI="http://pingus.seul.org/~grumbel/xboxdrv/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="daemon"

RDEPEND="dev-libs/boost
	virtual/libusb:0
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-util/scons"
RDEPEND="${RDEPEND}
	daemon? (
		dev-python/dbus-python
		dev-python/pygobject
	)"

S=${WORKDIR}/${MY_P}

CONFIG_CHECK="~INPUT_EVDEV ~INPUT_JOYDEV ~INPUT_UINPUT ~!JOYSTICK_XPAD"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	tc-export CXX
	scons || die "scons failed"
}

src_install() {
	dobin xboxdrv || die "dobin failed"

	if use daemon ; then
		dobin xboxdrv-daemon || die "dobin failed"
		doman doc/xboxdrv-daemon.1

		newinitd "${FILESDIR}"/xboxdrv.init xboxdrv
		newconfd "${FILESDIR}"/xboxdrv.conf xboxdrv
		
		insinto /etc/dbus-1/system.d
		newins "${FILESDIR}"/xboxdrv.dbus xboxdrv.conf
	fi

	insinto /etc/hal/fdi/policy
	newins hal/xboxdrv_policy.fdi 99-xboxdrv.fdi || die "newins failed"

	insinto /etc/hal/fdi/preprobe
	newins hal/xboxdrv_preprobe.fdi 99-xboxdrv.fdi || die "newins failed"

	doman doc/xboxdrv.1
	dodoc AUTHORS NEWS PROTOCOL README TODO
}

