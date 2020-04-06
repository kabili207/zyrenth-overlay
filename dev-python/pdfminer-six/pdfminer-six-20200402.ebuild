# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_{6,7,8})

inherit distutils-r1

MY_P="${PN//-/.}-${PV}"

DESCRIPTION="Python tool for extracting information from PDF documents"
HOMEPAGE="https://github.com/pdfminer/pdfminer.six"
SRC_URI="mirror://pypi/${MY_P:0:1}/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	${PYTHON_DEPS}
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/sortedcontainers[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"

S="${WORKDIR}/${MY_P}"
