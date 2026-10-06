# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{11..15})

inherit distutils-r1 pypi

MY_PN="Ulauncher"
MY_PV=$(ver_rs 3 '-')
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Feature rich application Launcher for Linux"
HOMEPAGE="https://github.com/Ulauncher/Ulauncher"
SRC_URI="https://github.com/Ulauncher/Ulauncher/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	${PYTHON_DEPS}
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/lefthook[${PYTHON_USEDEP}]
	dev-python/pyrefly[${PYTHON_USEDEP}]
	dev-python/ruff[${PYTHON_USEDEP}]
	dev-python/rumdl[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/typos[${PYTHON_USEDEP}]
	${RDEPEND}
"

S="${WORKDIR}/${MY_P}"
