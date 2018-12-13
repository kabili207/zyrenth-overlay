# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=(python2_7)

inherit distutils-r1

DESCRIPTION="Open source Google drive client written in python."
HOMEPAGE="https://github.com/hschauhan/gosync"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	${PYTHON_DEPS}
	dev-python/google-api-python-client[${PYTHON_USEDEP}]
	dev-python/pydrive[${PYTHON_USEDEP}]
	dev-python/watchdog[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"
PATCHES=(
	"${FILESDIR}"/${PV}-fix-setup.patch
)
