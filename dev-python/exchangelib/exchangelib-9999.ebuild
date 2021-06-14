# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_{7,8,9})

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
	>=dev-python/defusedxml-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/dnspython-1.14.0[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/isodate[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.0.0[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	>=dev-python/requests-2.7.0[${PYTHON_USEDEP}]
	>=dev-python/requests-ntlm-0.2.0[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"

DOCS="README.rst"
