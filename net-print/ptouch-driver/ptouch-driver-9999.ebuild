# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit mercurial eutils autotools

DESCRIPTION="Driver for the Brother P-touch series of label printers."
HOMEPAGE="https://bitbucket.org/philpem/printer-driver-ptouch"

SRC_URI=""

EHG_REPO_URI="https://bitbucket.org/philpem/printer-driver-ptouch"
EHG_REVISION="ptouch-driver"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	net-print/cups
	net-print/foomatic-db-engine"

DEPEND="${RDEPEND} "

src_prepare() {
	# Make sure we write the filter to the correct directory
	sed -i -e 's/\$(libdir)\/cups\/filter/\$(libexecdir)\/cups\/filter/' "${S}/Makefile.am" || die "Sed failed!"

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
