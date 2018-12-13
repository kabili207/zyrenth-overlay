# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=(python{2_7,3_4,3_5,3_6})

inherit distutils-r1

DESCRIPTION="GSM modem module for Python"
HOMEPAGE="https://github.com/babca/python-gsmmodem"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	${PYTHON_DEPS}
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/pyserial-3.1.1[${PYTHON_USEDEP}]
	${RDEPEND}
"
