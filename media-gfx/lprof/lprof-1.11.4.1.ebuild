# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/lprof/lprof-1.11.4.1.ebuild,v 1.3 2008/01/04 08:42:42 opfer Exp $

inherit eutils

DESCRIPTION="Little CMS ICC profile construction set"
HOMEPAGE="http://lprof.sourceforge.net/"
SRC_URI="mirror://sourceforge/lprof/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""
RDEPEND="=x11-libs/qt-3*
	>=media-libs/lcms-1.14
	>=media-libs/vigra-1.3.0
	>=media-libs/tiff-3.7.1"
DEPEND="${RDEPEND}
	dev-lang/python"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/lcms-1.17.patch
	epatch "${FILESDIR}"/scons120.patch
}

src_compile() {
	./scons.py ${MAKEOPTS} PREFIX=/usr || die "scons failed"
}

src_install() {
	dodoc README KNOWN_BUGS
	./scons.py PREFIX="${D}"/usr install || die "scons install failed"
}
