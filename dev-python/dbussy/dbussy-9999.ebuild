# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_{7,8})

inherit git-r3 distutils-r1

DESCRIPTION="Language bindings for libdbus, for Python"
HOMEPAGE="https://github.com/ldo/dbussy"
EGIT_REPO_URI="https://github.com/ldo/dbussy"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

RDEPEND="
	${PYTHON_DEPS}
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"
