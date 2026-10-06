# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

MY_PV=${PV//_/-}
DESCRIPTION="Application launcher for Linux"
HOMEPAGE="https://ulauncher.io"
SRC_URI="https://github.com/Ulauncher/${PN^}/releases/download/v${MY_PV}/${PN}-${MY_PV}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
PYTHON_REQ_USE="sqlite"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"

# TODO: handle libindicator
# dev-libs/libappindicator:3

RDEPEND="${DEPEND}
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/levenshtein[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/websocket-client[${PYTHON_USEDEP}]
	dev-libs/gobject-introspection:=
	dev-libs/keybinder:3
	net-libs/webkit-gtk:4.1/0
"

BDEPEND="${PYTHON_DEPS}"

src_install() {
	distutils-r1_src_install

	if [[ -f "${D}"/usr/share/man/man1/ulauncher.1.gz ]]; then
		gunzip "${D}"/usr/share/man/man1/ulauncher.1.gunzip
	fi
}