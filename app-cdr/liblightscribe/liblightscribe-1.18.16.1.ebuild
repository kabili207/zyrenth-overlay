# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils rpm multilib

SDK_PV=1.18.6.1

DESCRIPTION="LightScribe System Software (binary only library)."
HOMEPAGE="http://www.lightscribe.com/downloadSection/linux/index.aspx"
SRC_URI="http://download.lightscribe.com/ls/lightscribe-${PV}-linux-2.6-intel.rpm
	http://download.lightscribe.com/ls/lightscribePublicSDK-${SDK_PV}-linux-2.6-intel.rpm"

LICENSE="lightscribe lightscribeSDK"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="multilib -hardened"

DEPEND=""

RDEPEND="virtual/libc
	x86? ( sys-libs/libstdc++-v3 )
	amd64? ( sys-libs/libstdc++-v3[multilib] )
	!app-cdr/lightscribe"

RESTRICT="mirror strip fetch"

src_unpack() {
	rpm_src_unpack
}

src_prepare() {
	# make revdep-rebuild happy
	mv "${WORKDIR}"/usr/lib/liblightscribe.so.1 "${WORKDIR}"/usr/lib/liblightscribe.so.0.0.1

	# hack in to use provided libstdc++ rename it to libstdcv3
	mv "${WORKDIR}"/usr/lib/lightscribe/libstdc++.so.5.0.7 "${WORKDIR}"/usr/lib/lightscribe/libstdcv3.so.5.0.7
	sed -i "s/libstdc++.so.5/libstdcv3.so.5/g" "${WORKDIR}"/usr/lib/liblightscribe.so.0.0.1
	sed -i "s/libstdc++.so.5/libstdcv3.so.5/g" "${WORKDIR}"/usr/lib/lightscribe/libstdcv3.so.5.0.7
}

src_compile() { :; }

src_install() {
	has_multilib_profile && ABI="x86"

	exeinto /opt/lightscribe/$(get_libdir)/lightscribe/updates
	doexe "${WORKDIR}"/usr/lib/lightscribe/updates/fallback.sh || die "fallback.sh install failed"
	exeinto /opt/lightscribe/$(get_libdir)/lightscribe
	doexe "${WORKDIR}"/usr/lib/lightscribe/elcu.sh || die "elcu.sh install failed"
	into /opt/lightscribe
	dolib.so "${WORKDIR}"/usr/lib/liblightscribe.so.* || die "liblightscribe.so.* install failed"
	dolib.so "${WORKDIR}"/usr/lib/lightscribe/libstdcv3.so.* || die "libstdcv3.so.* install failed"
	dosym liblightscribe.so.0.0.1 /opt/lightscribe/$(get_libdir)/liblightscribe.so.1
	dosym liblightscribe.so.0.0.1 /opt/lightscribe/$(get_libdir)/liblightscribe.so
	insinto /usr/include/lightscribe
	doins -r "${WORKDIR}"/usr/include/* || die "includes install failed"
	insinto /etc
	doins -r "${WORKDIR}"/etc/* || die "config install failed"
	dosed "s%/usr/lib%/opt/lightscribe/$(get_libdir)%" /etc/lightscribe.rc
	dodoc "${WORKDIR}"/usr/share/doc/*.* \
	      "${WORKDIR}"/usr/share/doc/lightscribe-sdk/*.* \
	      "${WORKDIR}"/usr/share/doc/lightscribe-sdk/docs/* || die "doc install failed"
	docinto sample/lsprint
	dodoc "${WORKDIR}"/usr/share/doc/lightscribe-sdk/sample/lsprint/* || die "lsprint sample install failed"
	dodir /etc/env.d
	echo "LDPATH=/opt/lightscribe/$(get_libdir)" > "${D}"/etc/env.d/80lightscribe
}

pkg_postinst() {
	einfo
	einfo "This version also support Enhanced Contrast"
	einfo "You can activate it by running:"
	einfo "/opt/lightscribe/$(get_libdir)/lightscribe/elcu.sh"
	einfo
}

pkg_nofetch() {
	einfo "Please download the appropriate Lightscribe System Software & Linux Public SDK archive's"
	einfo "( lightscribe-${PV}-linux-2.6-intel.rpm"
	einfo "  lightscribePublicSDK-${SDK_PV}-linux-2.6-intel.rpm )"
	einfo "from ${HOMEPAGE} (requires to accept license)"
	einfo
	einfo "Then put the file in ${DISTDIR}"
}
