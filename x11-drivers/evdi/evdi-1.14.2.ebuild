# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="Extensible Virtual Display Interface"
HOMEPAGE="https://github.com/DisplayLink/evdi"
SRC_URI="https://github.com/DisplayLink/evdi/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="x11-libs/libdrm"
DEPEND="${RDEPEND}
	sys-kernel/linux-headers"

CONFIG_CHECK="~FB_VIRTUAL ~I2C DRM ~USB_SUPPORT USB_ARCH_HAS_HCD"

pkg_setup() {
	linux-mod-r1_pkg_setup
}

src_compile() {
	local modlist=( evdi=video:module )
	local modargs=(	KVER="${KV_FULL}" KDIR="${KV_OUT_DIR}" )
	linux-mod-r1_src_compile
	emake -C library
}

src_install() {
	linux-mod-r1_src_install
	MYLIBDIR="${EPREFIX}/usr/$(get_libdir)"
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}" LIBDIR="${MYLIBDIR}" -C library install
}
