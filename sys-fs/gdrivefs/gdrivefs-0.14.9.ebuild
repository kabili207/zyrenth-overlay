# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=(python2_7)

inherit distutils-r1

DESCRIPTION="A complete FUSE adapter for Google Drive."
HOMEPAGE="https://github.com/dsoprea/GDriveFS"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	${PYTHON_DEPS}
	dev-python/google-api-python-client[${PYTHON_USEDEP}]
	dev-python/fusepy[${PYTHON_USEDEP}]
	dev-python/greenlet[${PYTHON_USEDEP}]
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"
