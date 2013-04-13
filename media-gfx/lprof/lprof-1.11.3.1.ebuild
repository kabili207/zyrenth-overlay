# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/lprof/lprof-1.11.3.1.ebuild,v 1.2 2006/09/10 00:30:30 ticho Exp $

inherit eutils qt3

DESCRIPTION="Little CMS ICC profile construction set"
HOMEPAGE="http://lprof.sourceforge.net/"
SRC_URI="mirror://sourceforge/lprof/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""
DEPEND="=x11-libs/qt-3*
	>=media-libs/lcms-1.14
	>=media-libs/vigra-1.3.0
	>=media-libs/tiff-3.7.1"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc4.1fix.patch
	epatch ${FILESDIR}/${P}-noincludehint.patch
}

src_compile() {
	./scons.py ${MAKEOPTS} PREFIX=/usr || die "build failed"
}

src_install() {
	dodoc README COPYING KNOWN_BUGS
	./scons.py PREFIX=${D}/usr install
}
