# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit multilib git-2

DESCRIPTION="detox safely removes spaces and strange characters from filenames"
HOMEPAGE="http://www.zyrenth.com/"
EGIT_REPO_URI="git://zyrenth.com/g15-purple.git"
EGIT_COMMIT="b8f73a318ae63791a1b16debc96d4dddaea47478"
SRC_URI=""

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
#    emake DESTDIR="${D}" install
#    dodoc README CHANGES
}