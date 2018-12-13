# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=(python{2_7,3_4,3_5,3_6})

inherit distutils-r1

DESCRIPTION="Official Dropbox API Client"
HOMEPAGE="https://github.com/dropbox/dropbox-sdk-python"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/requests-2.16.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.3.0[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"
