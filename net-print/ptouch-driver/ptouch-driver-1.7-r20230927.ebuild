# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Driver for the Brother P-touch series of label printers."
HOMEPAGE="https://github.com/philpem/printer-driver-ptouch"
MY_PV="9f75468dd4e7e73770bfbafed79a05b3585ca28d"
SRC_URI="https://github.com/philpem/printer-driver-ptouch/archive/${MY_PV}.tar.gz -> ${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	net-print/cups
	net-print/foomatic-db-engine"

DEPEND="${RDEPEND} "

S="${WORKDIR}/printer-driver-ptouch-${MY_PV}"

src_prepare() {
	# Make sure we write the filter to the correct directory
	sed -i -e 's/\$(libdir)\/cups\/filter/\$(libexecdir)\/cups\/filter/' "${S}/Makefile.am" || die "Sed failed!"
	eautoreconf
	default
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
