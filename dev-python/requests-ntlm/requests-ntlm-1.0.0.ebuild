# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=(python{2_7,3_4,3_5,3_6})

inherit distutils-r1

DESCRIPTION="HTTP NTLM authentication using the requests library"
HOMEPAGE="https://github.com/requests/requests-ntlm"
SRC_URI="mirror://pypi/${P:0:1}/${PN//-/_}/${PN//-/_}-${PV}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/requests-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/ntlm-auth-1.0.2[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"

S="${WORKDIR}/${PN//-/_}-${PV}"

DOCS="README.rst"