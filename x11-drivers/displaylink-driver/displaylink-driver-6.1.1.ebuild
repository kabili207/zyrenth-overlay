# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd udev

DESCRIPTION="DisplayLink USB Graphics Software"
HOMEPAGE="http://www.displaylink.com/downloads/ubuntu"
SRC_URI="${P}.zip"
LICENSE="DisplayLink-EULA"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 "
IUSE="systemd"
PV_EXTRA="17"

QA_PREBUILT="/opt/displaylink/DisplayLinkManager"
RESTRICT="fetch bindist"

DEPEND="app-admin/chrpath
	app-arch/unzip"
RDEPEND=">=sys-devel/gcc-6.5.0
	x11-drivers/evdi:0/1.14
	virtual/libusb:1
	>=x11-base/xorg-server-1.17.0
	!systemd? ( sys-auth/elogind )"

pkg_nofetch() {
	einfo "Please download DisplayLink USB Graphics Software for Ubuntu${PV}-EXE.zip from"
	einfo "http://www.displaylink.com/downloads/ubuntu and save it to the distfiles folder"
	einfo "as ${P}.zip"
}

src_unpack() {
	default
	sh ./"${PN}-${PV}-${PV_EXTRA}".run --noexec --target "${P}"
}

src_install() {
	case "${ARCH}" in
		amd64)	MY_ARCH="x64-ubuntu-1604" ;;
		x86)	MY_ARCH="x86-ubuntu-1604" ;;
		arm)	MY_ARCH="arm-linux-gnueabihf" ;;
		arm64)	MY_ARCH="aarch64-linux-gnu" ;;
	esac
	DLM="${S}/${MY_ARCH}/DisplayLinkManager"

	dodir /opt/displaylink
	dodir /var/log/displaylink

	exeinto /opt/displaylink
	chrpath -d "${DLM}"
	doexe "${DLM}"

	insinto /opt/displaylink
	doins *.spkg

	udev_dorules "${FILESDIR}/99-displaylink.rules"

	insinto /opt/displaylink
	insopts -m0755
	newins "${FILESDIR}/udev.sh" udev.sh
	newins "${FILESDIR}/pm-displaylink" suspend.sh
	if use systemd; then
		dosym ../../../opt/displaylink/suspend.sh /lib/systemd/system-sleep/displaylink.sh
		systemd_dounit "${FILESDIR}/dlm.service"
	else
		dosym ../../../opt/displaylink/suspend.sh /etc/pm/sleep.d/displaylink.sh
		newinitd "${FILESDIR}/rc-displaylink-1.3" dlm
	fi
}

pkg_postinst() {
	udev_reload

	elog "The DisplayLinkManager Init is now called dlm"
	elog ""
	elog "You should be able to use xrandr as follows:"
	elog "xrandr --setprovideroutputsource 1 0"
	elog "Repeat for more screens, like:"
	elog "xrandr --setprovideroutputsource 2 0"
	elog "Then, you can use xrandr or GUI tools like arandr to configure the screens, e.g."
	elog "xrandr --output DVI-1-0 --auto"
}

pkg_postrm() {
	udev_reload
}
