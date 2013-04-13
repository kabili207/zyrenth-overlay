# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
# Taken from the bgo-overlay

EAPI="2"

inherit eutils

DESCRIPTION="Google Music Manager is a simple application for adding the music files on your computer to your Music library."
HOMEPAGE="http://music.google.com/"

SRC_URI="x86? ( http://dl.google.com/linux/direct/${PN}-beta_current_i386.deb ) 
		 amd64? ( http://dl.google.com/linux/direct/${PN}-beta_current_amd64.deb )"
RESTRICT="mirror strip"

LICENSE="google-musicmanager Apache-2.0 MIT LGPL gSOAP BSD MPL openssl ZLIB"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

RDEPEND=">=dev-libs/expat-1.95.8
		 >=media-libs/flac-1.2.1
		 >=media-libs/fontconfig-2.8.0
		 >=media-libs/freetype-2.2.1
		 >=net-dns/libidn-1.13
		 >=media-libs/libogg-1.0
		 >=x11-libs/qt-core-4.6.1
		 >=x11-libs/qt-gui-4.5.3
		 >=media-libs/libvorbis-1.1.2
		 x11-libs/libX11
		 x11-libs/libXext
		 x11-libs/libXi
		 x11-libs/libXrandr
		 x11-libs/libXrender
		 x11-misc/xdg-utils"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	unpack ./data.tar.lzma
	rm -f control.tar.gz data.tar.gz debian-binary
}

src_install() {
	dodir /opt/google/musicmanager/
	insinto /opt/google/musicmanager/
	doins opt/google/musicmanager/config.xml
	doins opt/google/musicmanager/lib*
	doins opt/google/musicmanager/minidump_upload
	doins opt/google/musicmanager/product_logo_*.png

	insinto /usr/share/pixmaps/
	newins opt/google/musicmanager/product_logo_32.xpm google-musicmanager.xpm

	dosym /opt/google/musicmanager/google-musicmanager /opt/bin/

	exeinto /opt/google/musicmanager/
	doexe opt/google/musicmanager/google-musicmanager
	doexe opt/google/musicmanager/MusicManager

	make_desktop_entry "${PN}" "Google Music Manager" "${PN}" "AudioVideo;Audio;Player;Music"
}
