# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib

DESCRIPTION="Pidgin plugin that displays incoming messages on a Logitech G15 LCD screen"
HOMEPAGE="https://github.com/kabili207/g15-purple"
EGIT_REPO_URI="https://github.com/kabili207/g15-purple.git"
EGIT_COMMIT="3f7562fab10ec48c6011a71568b5620d3de1717a"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

#RDEPEND=""
DEPEND="${RDEPEND}
	dev-libs/libg15render
	dev-libs/libg15
	app-misc/g15daemon
	net-im/pidgin"

src_install() {
	insinto /usr/$(get_libdir)/pidgin
	insopts -m755
	doins bin/g15purple.so || die
}