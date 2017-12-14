# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=(python{2_7,3_4,3_5,3_6})

inherit distutils-r1

DESCRIPTION="A Python abstraction class to access NUT servers"
HOMEPAGE="https://github.com/mezz64/python-nut2"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
    ${PYTHON_DEPS}
"
DEPEND="
    dev-python/setuptools[${PYTHON_USEDEP}]
    ${RDEPEND}
"

#DOCS="README.rst"

