# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=(python{2_7,3_4})

inherit git-r3 distutils-r1

DESCRIPTION="Python client for Microsoft Exchange Web Services (EWS)"
HOMEPAGE="https://github.com/ecederstrand/exchangelib"
EGIT_REPO_URI="https://github.com/ecederstrand/exchangelib"

LICENSE="BSD"
SLOT="0"
IUSE=""


RDEPEND="
	${PYTHON_DEPS}
	dev-python/cached-property[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	>=dev-python/requests-2.7.0[${PYTHON_USEDEP}]
	>=dev-python/requests-ntlm-0.2.0[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]
	>=dev-python/dnspython-1.14.0[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"

DOCS="README.rst"