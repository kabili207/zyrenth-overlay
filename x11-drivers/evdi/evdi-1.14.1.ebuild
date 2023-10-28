# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod

DESCRIPTION="Extensible Virtual Display Interface"
HOMEPAGE="https://github.com/DisplayLink/evdi"
SRC_URI="https://github.com/DisplayLink/evdi/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="x11-libs/libdrm"
DEPEND="${RDEPEND}
	sys-kernel/linux-headers"

MODULE_NAMES="evdi(video:${S}/module)"

#CONFIG_CHECK="~FB_VIRTUAL ~!INTEL_IOMMU"
CONFIG_CHECK="~FB_VIRTUAL ~I2C DRM ~USB_SUPPORT USB_ARCH_HAS_HCD"

pkg_setup() {
	linux-mod_pkg_setup
}

src_compile() {
	linux-mod_src_compile
	cd "${S}/library"
	default
	#mv libevdi.so libevdi.so.${PV}
}

src_install() {
	linux-mod_src_install
	dolib.so library/libevdi.so.${PV}
	dosym libevdi.so.${PV} "/usr/$(get_libdir)/libevdi.so.1"
	dosym libevdi.so.1 "/usr/$(get_libdir)/libevdi.so"
}
