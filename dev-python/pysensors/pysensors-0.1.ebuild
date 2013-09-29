# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 mercurial

DESCRIPTION="Python bindings for libsensors via ctypes."
HOMEPAGE="https://bitbucket.org/bastienleonard/pysensors/"
EHG_REPO_URI="https://bitbucket.org/bastienleonard/pysensors"
EHG_REVISION="0c149ea191f275508ba42c8e50c06a4e334f334b"
SRC_URI=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""


DEPEND="${RDEPEND}
    sys-apps/lm_sensors"

#S="${WORKDIR}"/PySensors-${PV}

