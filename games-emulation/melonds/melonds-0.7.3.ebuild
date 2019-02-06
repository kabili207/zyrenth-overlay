# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils wxwidgets

DESCRIPTION="Nintendo DS emulator"
HOMEPAGE="https://github.com/StapleButter/melonDS"

COMMIT_ID="4b6ebd053285658d9c4fe81104c8babdaf26d56a"
SRC_URI="https://github.com/StapleButter/melonDS/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/melonDS-${COMMIT_ID}"

RDEPEND="
	x11-libs/wxGTK:3.0=[X]
	>=media-libs/libsdl2-2.0.5
"
DEPEND="
	${RDEPEND}
"

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		ewarn ""
		ewarn "In order to run, the following files must placed in ~/.config/melonds:"
		ewarn "bios7.bin"
		ewarn "bios9.bin"
		ewarn "firmware.bin"
		ewarn ""
	fi
}
