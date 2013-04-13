# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit multilib

DESCRIPTION="Adobe AIR SDK"
HOMEPAGE="http://www.adobe.com/products/air/tools/sdk/"
SRC_URI="http://airdownload.adobe.com/air/lin/download/latest/AdobeAIRSDK.tbz2"
RESTRICT="fetch"

LICENSE="AdobeAirSDK"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=dev-libs/nss-3*
	=dev-libs/nspr-4*"

pkg_nofetch() {
	einfo "Please go to ${HOMEPAGE}, read and accept the EULA and download"
	einfo "Adobe AIR Software Development Kit for Linux"
	einfo "Place the file AdobeAIRSDK.tbz2 in ${DISTDIR}."
	echo
	einfo "New versions of Adobe AIR will break the ebuild (i.e. the version"
	einfo "number will be wrong)"
}

src_install() {
	AIR_BASE="/opt/Adobe/AirSDK"
	APP_BASE="/opt/Adobe/AirApps"
	insinto ${AIR_BASE}
	ebegin "Removing broken symlinks"
	rm runtimes/air/linux/Adobe\ AIR/Versions/1.0/Resources/nss3/0d/*
	rm runtimes/air/linux/Adobe\ AIR/Versions/1.0/Resources/nss3/1d/*
	rm runtimes/air/linux/Adobe\ AIR/Versions/1.0/Resources/nss3/None/*
	eend
	ebegin "Setting sane permissions to files"
	find -type f -exec chmod 0644 {} \;
	find -type d -exec chmod 0755 {} \;
	eend

	doins -r *
	dodir ${APP_BASE}

	ebegin "Re-setting execute permissions"
	fperms 0755 ${AIR_BASE}/bin/adt
	fperms 0755 ${AIR_BASE}/bin/adl
	find ${D}/${AIR_BASE} -depth -type f -name "*.so" -exec chmod 0755 {} \;
	eend
	ebegin "Recreating symlinks"
	for dir in 0d 1d None; do
		cd ${D}/${AIR_BASE}/runtimes/air/linux/Adobe\ AIR/Versions/1.0/Resources/nss3/$dir
		ln -s ${D}/usr/$(get_libdir)/nss/libnss3.so libnss3.so
		ln -s ${D}/usr/$(get_libdir)/nss/libsmime3.so libsmime3.so
		ln -s ${D}/usr/$(get_libdir)/nss/libssl3.so libssl3.so
		ln -s ${D}/usr/$(get_libdir)/nspr/libnspr4.so libnspr4.so
		ln -s ${D}/usr/$(get_libdir)/nspr/libplc4.so libplc4.so
		ln -s ${D}/usr/$(get_libdir)/nspr/libplds4.so libplds4.so
	done
	eend
	
	cat <<- EOF > airstart
	#!/bin/sh
	${AIR_BASE}/bin/adl -nodebug "${APP_BASE}/\$1/META-INF/AIR/application.xml" "${APP_BASE}/\$1"
	EOF
	
	dobin airstart
}

pkg_postinst() {
	einfo "Unzip the .air files to ${APP_BASE}/<appname>/"
	einfo "and run them by:"
	einfo "airstart <appname>"
}
