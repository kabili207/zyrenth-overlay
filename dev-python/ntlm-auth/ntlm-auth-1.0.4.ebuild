# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=(python{2_7,3_4,3_5,3_6})

inherit distutils-r1

DESCRIPTION="Create and parse NTLM authorisation tokens with all the latest standards"
HOMEPAGE="https://github.com/jborean93/ntlm-auth"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	${PYTHON_DEPS}
	dev-python/six[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/ordereddict[${PYTHON_USEDEP}]' python2_7)
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		dev-python/unittest2[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
	)
	${RDEPEND}
"

python_test() {
	distutils_install_for_testing
	py.test --ignore=tests/functional/test_iis.py --cov ntlm_auth --cov-report term-missing tests || die "tests failed"
}