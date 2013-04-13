# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils rpm multilib

DESCRIPTION="LightScribe Simple Labeler by HP (binary only GUI)"
HOMEPAGE="http://www.lightscribe.com/downloadSection/linux/index.aspx"
SRC_URI="http://download.lightscribe.com/ls/lightscribeApplications-${PV}-linux-2.6-intel.rpm"

LICENSE="lightscribe"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="multilib"

DEPEND=""

RDEPEND="virtual/libc
	>=app-cdr/liblightscribe-1.4.113.1
	x86?  ( sys-libs/libstdc++-v3
		>=media-libs/fontconfig-2.3.2
		>=media-libs/freetype-2.1.10
		>=media-libs/libpng-1.2.8
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/qt-core[qt3support]
		x11-libs/qt-gui[qt3support]
		x11-libs/qt-qt3support
		x11-libs/qt-sql[qt3support] )
	amd64? ( app-emulation/emul-linux-x86-xlibs
		 app-emulation/emul-linux-x86-baselibs
		 sys-libs/libstdc++-v3[multilib] )
	sys-devel/gcc
	sys-libs/zlib"

RESTRICT="mirror strip fetch"

src_unpack() {
	rpm_src_unpack
}

src_compile() { :; }

src_install() {
	has_multilib_profile && ABI="x86"

	into /opt/lightscribe/SimpleLabeler
	exeinto /opt/lightscribe/SimpleLabeler
	doexe "${WORKDIR}"/opt/lightscribeApplications/SimpleLabeler/SimpleLabeler
	doexe "${WORKDIR}"/opt/lightscribeApplications/SimpleLabeler/*.*
	exeinto /opt/lightscribe/SimpleLabeler/plugins/accessible
	doexe "${WORKDIR}"/opt/lightscribeApplications/SimpleLabeler/plugins/accessible/*.so
	insinto /opt/lightscribe/SimpleLabeler/content
	doins -r "${WORKDIR}"/opt/lightscribeApplications/SimpleLabeler/content/*
	use amd64 && dolib.so "${WORKDIR}"/opt/lightscribeApplications/common/Qt/*
	dodoc "${WORKDIR}"/opt/lightscribeApplications/*.*
	into /opt
	make_wrapper SimpleLabeler "./SimpleLabeler" /opt/lightscribe/SimpleLabeler /usr/$(get_libdir)/libstdc++-v3


	# cope with libraries being in /opt/lightscribe/SimpleLabeler/lib
	use amd64 && dodir /etc/env.d
	use amd64 && echo "LDPATH=/opt/lightscribe/SimpleLabeler/$(get_libdir)" > "${D}"/etc/env.d/80lightscribe-simplelabeler

	newicon "${WORKDIR}"/opt/lightscribeApplications/SimpleLabeler/content/images/LabelWizardIcon.png ${PN}.png
	make_desktop_entry SimpleLabeler "LightScribe Simple Labeler" ${PN}.png "Application;AudioVideo;DiscBurning;Recorder;"
}

pkg_nofetch() {
	einfo "Please download the appropriate Lightscribe Simple Labeler archive"
	einfo "( lightscribeApplications-${PV}-linux-2.6-intel.rpm )"
	einfo "from ${HOMEPAGE} (requires to accept license)"
	einfo
	einfo "Then put the file in ${DISTDIR}"
}
