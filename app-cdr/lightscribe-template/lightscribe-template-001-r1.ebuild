# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

TL="Food-n-Family Hobby Floral KidsKorner
    Business 9-to-5 Architecture
    Art Fantasy Urban Tattoo Music Mythology Tribal StreetStyle KickinIt GrabBag
    Sports Athletic Travel Animal Nature
    Wedding SpecialOccasion Holiday Bridal Seasonal LifeEvents Celebration
    Bonus QuickAndSimple"

DESCRIPTION="Explore designs with the same themes, along with creative extras."
HOMEPAGE="http://www.lightscribe.com/ideas/index_top.aspx"

SRC_URI=""
for a in ${TL}
do
	SRC_URI="${SRC_URI} http://download.lightscribe.com/ls/TL_${a}Pack${PV}.tar.gz"
done

LICENSE="lightscribe"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

RDEPEND=""

RESTRICT="mirror"

src_unpack() {
	for a in ${TL}
	do
		mkdir -p "${WORKDIR}"/${a}
		cd "${WORKDIR}"/${a}
		unpack TL_${a}Pack${PV}.tar.gz
	done
}

src_compile() { :; }

src_install() {
	for a in ${TL}
	do
		insinto /opt/lightscribe/template/${a}
		doins "${WORKDIR}"/${a}/*
	done
}
