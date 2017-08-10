# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

inherit eutils versionator systemd

DESCRIPTION="Linux led controller for Logitech G410, G610, G810 and G910 Keyboards"
HOMEPAGE="https://github.com/MatMoul/g810-led"

#MY_PV=$(replace_all_version_separators '-')

SRC_URI="https://github.com/MatMoul/g810-led/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+hidapi libusb"
REQUIRED_USE="hidapi? ( !libusb )"

RDEPEND="
    hidapi? ( dev-libs/hidapi )
	libusb? ( virtual/libusb )"

DEPEND="${RDEPEND} "

#S="${WORKDIR}/philpem-printer-driver-ptouch-${COMMIT_NUMBER}"

src_prepare() {
	# Make sure we write the filter to the correct directory
	sed -i -e 's/ \/etc\// \$(DESTDIR)\/etc\//' "${S}/makefile" || die "Sed failed!"
	default
}


src_compile() {
	my_lib=""
	if use hidapi; then
		my_lib="hidapi"
	else
		my_lib="libusb"
	fi

	emake LIB="${my_lib}" || die "emake failed"
}


src_install() {
	dolib.so "lib/libg810-led.so.${PV}"
	dosym "libg810-led.so.${PV}" "usr/$(get_libdir)/libg810-led.so"

	dobin bin/g810-led
	boards=(213 410 413 610 910 pro)
	for x in ${boards[@]}; do
		dosym g810-led "/usr/bin/g${x}-led"
	done

	systemd_dounit systemd/g810-led.service
	systemd_dounit systemd/g810-led-reboot.service

	insinto /lib/udev/rules.d/
	newins udev/g810-led.rules 60-g810-led.rules

	dodoc README.md
	dodoc -r sample_profiles
}
