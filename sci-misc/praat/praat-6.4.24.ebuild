# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Speech analysis and synthesis"
HOMEPAGE="http://www.fon.hum.uva.nl/praat/ https://github.com/praat/praat"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/praat-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+pulseaudio static-libs +X"

DEPEND="
	pulseaudio? ( || ( media-sound/pulseaudio-daemon media-video/pipewire ) )
	static-libs? ( media-libs/alsa-lib )
	X? ( x11-libs/gtk+:3 )
	!X? ( x11-libs/pango )"

RDEPEND="${DEPEND}"

src_prepare() {
	if use X; then
		if use static-libs; then
			if use pulseaudio; then
				cp "${S}/makefiles/makefile.defs.linux.pulse_static" "${S}/makefile.defs"
			else
				cp "${S}/makefiles/makefile.defs.linux.alsa" "${S}/makefile.defs"
			fi
		else
			if use pulseaudio; then
				cp "${S}/makefiles/makefile.defs.linux.pulse" "${S}/makefile.defs"
			else
				cp "${S}/makefiles/makefile.defs.linux.silent" "${S}/makefile.defs"
			fi
		fi
	else
		cp "${S}/makefiles/makefile.defs.linux.nogui" "${S}/makefile.defs"
	fi
	cat <<-EOF >> makefile.defs
		CFLAGS += ${CFLAGS}
		LDFLAGS += ${LDFLAGS}
		CXXFLAGS += ${CXXFLAGS}
	EOF
	default
}

src_install() {
	if [ -e praat_nogui ]; then
		mv praat_nogui praat
	elif [ -e praat_static ]; then
		mv praat_static praat
	fi
	dobin praat
	insinto /usr/share/${PN}/test
	doins -r test/*

	if use X; then
		cd "${S}/main/"
		newicon -s scalable praat-480.svg praat.svg
		domenu praat.desktop
	fi
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
