# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit multilib unpacker

DESCRIPTION="A fast and secure web browser"
HOMEPAGE="http://www.opera.com/"
SRC_URI_BASE="http://get.geo.opera.com/pub/"
SRC_URI="
	amd64? ( "${SRC_URI_BASE}${PN}/${PV}/linux/${PN}_${PV}_amd64.deb" )
"

LICENSE="OPERA-2014"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-arch/deb2targz"
RDEPEND="
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	=dev-libs/openssl-1.0.1*
	media-libs/alsa-lib
	sys-apps/dbus
	sys-libs/libcap
	virtual/libudev
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/libXScrnSaver
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/pango
"

QA_PREBUILT="*"
S=${WORKDIR}

src_unpack() {
	unpack_deb ${A}
}

src_prepare() {
	mv usr/lib/x86_64-linux-gnu usr/$(get_libdir) || die
	rm -r usr/lib || die

	rm usr/bin/${PN} || die

	rm usr/share/doc/${PN}/copyright || die
	mv usr/share/doc/${PN} usr/share/doc/${PF} || die

	if [[ ${LINGUAS} ]]; then
		use amd64 && local o_l_path="usr/$(get_libdir)/${PN}/localization/"
		local linguas=$(
			echo ${o_l_path}*.pak | sed -e "s|${o_l_path}||g;s|.pak||g" || die
		)
		local o_l
		for o_l in ${linguas}; do
			if ! has ${o_l} ${LINGUAS}; then
				rm ${o_l_path}/${o_l}.pak || die
			fi
		done
	fi

	sed -i \
		-e 's|^TargetEnvironment|X-&|g' \
		usr/share/applications/opera-developer.desktop || die
}

src_install() {
	cp -a * "${D}" || die
	dosym ../$(get_libdir)/${PN}/opera /usr/bin/${PN}
	fperms 4711 /usr/$(get_libdir)/${PN}/opera_sandbox
}
