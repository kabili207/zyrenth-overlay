# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-utils wxwidgets

DESCRIPTION="Nintendo DS emulator"
HOMEPAGE="https://github.com/StapleButter/melonDS"
EGIT_REPO_URI="https://github.com/StapleButter/melonDS"

LICENSE="GPL-3+"
SLOT="0"
IUSE=""

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
		ewarn "Currently, you need the following files in the folder you execute melonDS from:"
		ewarn "bios7.bin"
		ewarn "bios9.bin"
		ewarn "firmware.bin"
		ewarn ""
	fi
}
