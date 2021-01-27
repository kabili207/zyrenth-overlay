# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_{6,7,8})

inherit distutils-r1
DESCRIPTION="Helps you create JSON files with Python and JavaScript style inline comments."
HOMEPAGE="https://github.com/vaidik/commentjson"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/lark-parser-0.7.1[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
"

DOCS="README.rst"
