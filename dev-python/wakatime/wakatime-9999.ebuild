# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=(python{2_7,3_4,3_5,3_6})

inherit git-r3 distutils-r1

DESCRIPTION="Common interface to the WakaTime api"
HOMEPAGE="https://github.com/wakatime/wakatime"
EGIT_REPO_URI="https://github.com/wakatime/wakatime"

LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="
	${PYTHON_DEPS}
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"

DOCS="README.rst"