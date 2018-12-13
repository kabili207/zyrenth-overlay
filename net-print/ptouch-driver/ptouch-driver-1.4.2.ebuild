# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils autotools versionator

DESCRIPTION="Driver for the Brother P-touch series of label printers."
HOMEPAGE="https://bitbucket.org/philpem/printer-driver-ptouch"

COMMIT_NUMBER="72121843b720"

SRC_URI="https://bitbucket.org/philpem/printer-driver-ptouch/get/${COMMIT_NUMBER}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	net-print/cups
	net-print/foomatic-db-engine"

DEPEND="${RDEPEND} "

S="${WORKDIR}/philpem-printer-driver-ptouch-${COMMIT_NUMBER}"

src_prepare() {
	# Make sure we write the filter to the correct directory
	sed -i -e 's/\$(libdir)\/cups\/filter/\$(libexecdir)\/cups\/filter/' "${S}/Makefile.am" || die "Sed failed!"

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
