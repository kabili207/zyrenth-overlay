# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=(python{2_7,3_4,3_5,3_6})

inherit distutils-r1

DESCRIPTION="A library to retrieve coordinates from an google account that has been shared locations of other accounts."
HOMEPAGE="https://github.com/costastf/locationsharinglib"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	${PYTHON_DEPS}
	=dev-python/cachetools-2.0.1[${PYTHON_USEDEP}]
	=dev-python/beautifulsoup-4.6.0[${PYTHON_USEDEP}]
	=dev-python/requests-2.19.1[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"

