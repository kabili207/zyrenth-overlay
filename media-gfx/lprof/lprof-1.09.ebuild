# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/lprof/lprof-1.09.ebuild,v 1.7 2005/08/27 16:49:13 lanius Exp $

inherit eutils

DESCRIPTION="Little CMS ICC profile construction set"
HOMEPAGE="http://www.littlecms.com/profilers.htm"
SRC_URI="http://www.littlecms.com/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""
DEPEND="x11-libs/qt
	>=media-libs/lcms-1.09"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}_mrr_patch4.patch
	epatch ${FILESDIR}/${P}_fix-include.patch
}

src_compile() {
	addpredict ${QTDIR}/etc/settings
	emake || die
}

src_install() {
	dodoc README COPYING manual.txt
	exeinto /usr/bin
	doexe {icc2it8,qtmeasurementtool,qtmonitorprofiler,qtprofilechecker,qtscannerprofiler}
	dodir /usr/share/lprof
	cp -pPR ${S}/{pics,profiles,targets,template} ${D}/usr/share/lprof
}
