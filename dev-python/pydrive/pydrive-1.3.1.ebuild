# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=(python2_7)

inherit distutils-r1

MY_P="PyDrive-${PV}"

DESCRIPTION="Google Drive API made easy."
HOMEPAGE="https://github.com/gsuitedevs/PyDrive"
SRC_URI="mirror://pypi/${MY_P:0:1}/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/google-api-python-client-1.2[${PYTHON_USEDEP}]
	>=dev-python/oauth2client-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.0[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"

S="${WORKDIR}/${MY_P}"
