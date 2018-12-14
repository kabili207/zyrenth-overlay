# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=(python{3_5,3_6})

inherit distutils-r1

DESCRIPTION="Language bindings for libdbus, for Python"
HOMEPAGE="https://github.com/ldo/dbussy"
# Source isn't on pypi...
SRC_URI="https://github.com/ldo/dbussy/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1+"
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
