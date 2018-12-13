# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils wxwidgets

DESCRIPTION="Nintendo DS emulator"
HOMEPAGE="https://github.com/StapleButter/melonDS"

COMMIT_ID="3c270b65a0da343fee20db3b6029a8797f17e087"
SRC_URI="https://github.com/StapleButter/melonDS/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/melonDS-${COMMIT_ID}"

RDEPEND="
	x11-libs/wxGTK:3.0=[X]
	>=media-libs/libsdl2-2.0.5
"
DEPEND="
	${RDEPEND}
"