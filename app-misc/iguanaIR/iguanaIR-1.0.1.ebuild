# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/iguanaIR/iguanaIR-0.93.ebuild,v 1.4 2010/03/10 09:29:05 josejx Exp $

inherit eutils flag-o-matic versionator

DESCRIPTION="library for Irman control of Unix software"
HOMEPAGE="http://iguanaworks.net/index.php"
MY_PV=$(replace_version_separator _)
MY_P="${PN}-${MY_PV}"
SRC_URI="http://iguanaworks.net/downloads/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-libs/libusb-compat"
RDEPEND="sys-apps/lsb-release ${DEPEND}"

pkg_setup() {
	append-flags -fPIC
	enewgroup iguanair
	enewuser iguanair -1 -1 -1 'iguanair,usb'
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-1.0-gentoo.diff
}

src_install() {
	emake DESTDIR="${D}" install || die
}

