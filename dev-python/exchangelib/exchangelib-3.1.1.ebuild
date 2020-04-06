# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_{6,7})

inherit distutils-r1

DESCRIPTION="Python client for Microsoft Exchange Web Services (EWS)"
HOMEPAGE="https://github.com/ecederstrand/exchangelib"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
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
