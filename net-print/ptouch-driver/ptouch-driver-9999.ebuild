# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit git-r3 eutils autotools

DESCRIPTION="Driver for the Brother P-touch series of label printers."
HOMEPAGE="https://github.com/philpem/printer-driver-ptouch"
EGIT_REPO_URI="https://github.com/philpem/printer-driver-ptouch"

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
