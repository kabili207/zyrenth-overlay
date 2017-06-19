# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3 cmake-utils 

DESCRIPTION="Nintendo DS emulator"
HOMEPAGE="https://github.com/StapleButter/melonDS"
EGIT_REPO_URI="https://github.com/StapleButter/melonDS"

LICENSE="GPL3"
SLOT="0"
IUSE=""


RDEPEND="
	x11-libs/wxGTK
	>=media-libs/libsdl2-2.0.5
"
DEPEND="
	${RDEPEND}
"