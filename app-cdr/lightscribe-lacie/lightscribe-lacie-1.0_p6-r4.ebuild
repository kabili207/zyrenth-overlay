# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils rpm

MY_PV="${PV/_p/-r}"

DESCRIPTION="LaCie LightScribe Labeler 4L (binary only GUI)"
HOMEPAGE="http://www.lacie.com/products/product.htm?pid=10803"
SRC_URI="http://www.lacie.com/download/drivers/4L-${MY_PV}.i586.rpm
	http://eventi.vnunet.it/images/lacie.png"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="multilib"

DEPEND=""

RDEPEND="virtual/libc
	>=sys-devel/gcc-3.4
	>=app-cdr/liblightscribe-1.4.113.1
	x86? ( sys-libs/libstdc++-v3
	       >=media-libs/fontconfig-2.3.2
	       >=media-libs/freetype-2.1.10
	       x11-libs/libX11
	       x11-libs/libXcursor
	       x11-libs/libXext
	       x11-libs/libXi
	       x11-libs/libXinerama
	       x11-libs/libXrandr
	       x11-libs/libXrender )
	amd64? ( app-emulation/emul-linux-x86-xlibs
		 sys-libs/libstdc++-v3[multilib] )
	!app-cdr/lacie-lightscribe-labeler"

RESTRICT="mirror strip"

src_unpack() {
	rpm_src_unpack
}

src_compile() { :; }

src_install() {
	has_multilib_profile && ABI="x86"

	exeinto /opt/lightscribe/4L
	doexe "${WORKDIR}"/usr/4L/4L-*
	doexe "${WORKDIR}"/usr/4L/lacie*
	insinto /opt/lightscribe/4L/translations
	doins -r "${WORKDIR}"/usr/4L/translations/*
	dodoc "${WORKDIR}"/usr/4L/doc/*
	docinto templates
	dodoc "${WORKDIR}"/usr/4L/templates/*
	into /opt
	make_wrapper 4L-gui "./4L-gui" /opt/lightscribe/4L /usr/$(get_libdir)/libstdc++-v3
	make_wrapper 4L-cli "./4L-cli" /opt/lightscribe/4L /usr/$(get_libdir)/libstdc++-v3
	fperms u+s /opt/lightscribe/4L/4L-gui
	fperms u+s /opt/lightscribe/4L/4L-cli

	newicon "${DISTDIR}"/lacie.png ${PN}.png
	make_desktop_entry 4L-gui "Lacie LightScribe Labeler" ${PN}.png "Application;AudioVideo;DiscBurning;Recorder;"
}
