# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit udev

DESCRIPTION="ASEDriveIIIe USB Card Reader"
HOMEPAGE="http://www.athena-scs.com"
SRC_URI="https://web.archive.org/web/20180601000000/http://www.athena-scs.com/downloads/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"
RDEPEND="
	>=sys-apps/pcsc-lite-1.3.0
	virtual/libusb:0
	virtual/udev"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${P}-udev_rules.patch"
)

src_configure() {
	econf --with-udev-rules-dir="$(get_udevdir)"/rules.d
}

pkg_postinst() {
	udev_reload
	elog "NOTICE:"
	elog "You should restart pcscd."
}
