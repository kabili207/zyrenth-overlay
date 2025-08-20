# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{12..14})

inherit git-r3 distutils-r1

DESCRIPTION="Language bindings for libdbus, for Python"
HOMEPAGE="https://gitlab.com/ldo/dbussy https://bitbucket.org/ldo17/dbussy"
EGIT_REPO_URI="https://gitlab.com/ldo/dbussy"

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
