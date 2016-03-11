# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

[[ ${PV} = *9999* ]] && VCS_ECLASS="git-2" || VCS_ECLASS=""

inherit cmake-utils versionator ${VCS_ECLASS}

DESCRIPTION="Spectrum is a XMPP transport/gateway"
HOMEPAGE="http://spectrum.im"
if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="git://github.com/hanzz/spectrum2.git"
else
	MY_PN="spectrum"
	MY_PV=$(replace_version_separator '_' '-')
	MY_P="${MY_PN}-${MY_PV}"
	SRC_URI="https://github.com/hanzz/spectrum2/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/spectrum2-${MY_PV}"
fi

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE_PLUGINS="frotz irc jabber purple skype sms twitter yahoo"
IUSE="debug doc libev mysql postgres sqlite test ${IUSE_PLUGINS}"

# Richard H. <chain@rpgfiction.net> (2012-10-17): 2.0_beta2 does only build with swift-2.0_beta1
[[ ${PV} = *9999* ]] && RDEPEND="net-im/swiften" || RDEPEND=">=net-im/swiften-3.0"

RDEPEND="${RDEPEND}
	dev-libs/libev
	dev-libs/log4cxx
	dev-libs/openssl
	dev-libs/popt
	dev-libs/protobuf
	mysql? ( virtual/mysql )
	postgres? ( dev-libs/libpqxx )
	sqlite? ( dev-db/sqlite:3 )
	irc? ( net-im/communi )
	purple? ( >=net-im/pidgin-2.6.0 )
	skype? ( dev-libs/dbus-glib x11-base/xorg-server[xvfb] net-im/skype )
	libev? ( dev-libs/libev )
	"

DEPEND="${RDEPEND}
	dev-util/cmake
	sys-devel/gettext
	doc? ( app-doc/doxygen )
	test? ( dev-util/cppunit )
	"

REQUIRED_USE="|| ( sqlite mysql postgres )"

pkg_setup() {
	CMAKE_IN_SOURCE_BUILD=1
	use debug && CMAKE_BUILD_TYPE=Debug
	MYCMAKEARGS="-DLIB_INSTALL_DIR=$(get_libdir)"
}

src_prepare() {
	# no patches as of now
	#epatch "${FILESDIR}"/spectrum2-.patch
	base_src_prepare
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable mysql MYSQL)
		$(cmake-utils_use_enable postgres PQXX)
		$(cmake-utils_use_enable sqlite SQLITE3)
		$(cmake-utils_use_enable doc DOCS)
		$(cmake-utils_use_enable frotz FROTZ)
		$(cmake-utils_use_enable irc IRC)
		$(cmake-utils_use_enable jabber SWIFTEN)
		$(cmake-utils_use_enable purple PURPLE)
		$(cmake-utils_use_enable skype SKYPE)
		$(cmake-utils_use_enable sms SMSTOOLS3)
		$(cmake-utils_use_enable twitter TWITTER)
		$(cmake-utils_use_enable yahoo YAHOO2)
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	newinitd "${FILESDIR}"/spectrum2.initd spectrum2
	keepdir "${EPREFIX}"/var/lib/spectrum2
	keepdir "${EPREFIX}"/var/log/spectrum2
	keepdir "${EPREFIX}"/var/run/spectrum2
}


pkg_postinst() {
	# Create jabber-user
	enewgroup jabber
	enewuser jabber -1 -1 -1 jabber

	# Set correct rights
	chown jabber:jabber -R "/etc/spectrum2" || die
	chown jabber:jabber -R "${EPREFIX}/var/log/spectrum2" || die
	chown jabber:jabber -R "${EPREFIX}/var/run/spectrum2" || die
	chmod 750 "/etc/spectrum2" || die
	chmod 750 "${EPREFIX}/var/log/spectrum2" || die
	chmod 750 "${EPREFIX}/var/run/spectrum2" || die
}
