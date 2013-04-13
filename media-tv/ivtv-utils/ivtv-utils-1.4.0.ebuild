# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/ivtv-utils/ivtv-utils-1.3.0-r1.ebuild,v 1.3 2009/03/03 16:48:58 beandog Exp $

inherit eutils linux-mod

DESCRIPTION="IVTV utilities for Hauppauge PVR PCI cards"
HOMEPAGE="http://www.ivtvdriver.org"
SRC_URI="http://dl.ivtvdriver.org/ivtv/archive/1.4.x/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
IUSE="perl"
RDEPEND=">=sys-fs/udev-103"
DEPEND="app-arch/unzip
	>=sys-kernel/linux-headers-2.6.29
	!media-tv/ivtv"
PDEPEND=">=media-tv/ivtv-firmware-20070217
	perl? (
		dev-perl/Video-Frequencies
		dev-perl/Video-ivtv
		dev-perl/Config-IniFiles
		virtual/perl-Getopt-Long
		dev-perl/perl-tk )"

pkg_setup() {

	MODULE_NAMES="saa717x(extra:${S}/i2c-drivers)"
	BUILD_TARGETS="all"
	CONFIG_CHECK="EXPERIMENTAL HAS_IOMEM FW_LOADER I2C I2C_ALGOBIT
		VIDEO_DEV VIDEO_CAPTURE_DRIVERS VIDEO_V4L1 VIDEO_V4L2 VIDEO_IVTV"

	if ! ( kernel_is ge 2 6 29 ); then
		eerror "This package is only for the fully in-kernel"
		eerror "IVTV driver shipping with kernel 2.6.29 and higher"
		eerror ""
		eerror "You will need to either:"
		eerror "a) emerge an older version of this package if your kernel is
		higher than 2.6.26"
		eerror "b) emerge a 2.6.29.x or higher kernel"
		eerror "c) emerge media-tv/ivtv"
		eerror ""
		eerror "See http://ivtvdriver.org/ for more information"
		die "This only works on 2.6.29 and newer kernels"
	fi

	ewarn ""
	ewarn "Make sure that your I2C and V4L kernel drivers are loaded as"
	ewarn "modules, and not compiled into the kernel, or IVTV will not"
	ewarn "work."
	ewarn ""

	linux-mod_pkg_setup

	BUILD_PARAMS="KDIR=${KV_DIR}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-2.6.29.patch
}

src_compile() {
	emake  || die "failed to build"
}

src_install() {
	make DESTDIR="${D}" PREFIX="/usr" install || die "failed to install"
	use perl && dobin utils/perl/*.pl

	cd "${S}"
	dodoc README doc/* ChangeLog
	use perl && dodoc utils/perl/README.ptune
}

pkg_postinst() {
	elog ""
	elog "This version of the IVTV utils supports the following hardware:"
	elog "Hauppauge WinTV PVR-250"
	elog "Hauppauge WinTV PVR-350"
	elog "Hauppauge WinTV PVR-150"
	elog "Hauppauge WinTV PVR-500"
	elog "AVerMedia M179"
	elog "Yuan MPG600/Kuroutoshikou iTVC16-STVLP"
	elog "Yuan MPG160/Kuroutoshikou iTVC15-STVLP"
	elog "Yuan PG600/DiamondMM PVR-550 (CX Falcon 2)"
	elog "Adaptec AVC-2410"
	elog "Adaptec AVC-2010"
	elog "Nagase Transgear 5000TV"
	elog "AOpen VA2000MAX-STN6"
	elog "Yuan MPG600GR/Kuroutoshikou CX23416GYC-STVLP"
	elog "I/O Data GV-MVP/RX"
	elog "I/O Data GV-MVP/RX2E"
	elog "Gotview PCI DVD (preliminary support only)"
	elog "Gotview PCI DVD2 Deluxe"
	elog "Yuan MPC622"
	elog ""
	ewarn ""
	ewarn "IMPORTANT: In case of problems first read this page:"
	ewarn "http://www.ivtvdriver.org/index.php/Troubleshooting"
	ewarn ""
	ewarn "If any of these conditions match your setup, you may want to look at the"
	ewarn "README in /usr/share/doc/${PF}/"
	ewarn ""
	ewarn " - Using MythTV, a PVR-350 and the ivtvfb module"
	ewarn " - Using the ivtv X driver and the ivtvfb module"
	ewarn " - You want to manually build ivtv against v4l-dvb"
	ewarn ""
	ewarn "Also, the ivtv package comes with lots of documentation regarding setup,"
	ewarn "proper use and debugging utilities."
	ewarn "They are also located in /usr/share/doc/${PF}/"
	ewarn ""
	ewarn "For more information, see the IVTV driver homepage at:"
	ewarn "http://www.ivtvdriver.org/"
}
