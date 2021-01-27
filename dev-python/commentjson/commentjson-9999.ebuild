# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=(python3_{6,7,8})

inherit git-r3 distutils-r1

DESCRIPTION="Helps you create JSON files with Python and JavaScript style inline comments."
HOMEPAGE="https://github.com/vaidik/commentjson"
EGIT_REPO_URI="https://github.com/vaidik/commentjson"

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/lark-parser-0.7.1[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
"

DOCS="README.rst"
