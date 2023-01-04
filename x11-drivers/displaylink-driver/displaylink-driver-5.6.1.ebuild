# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils systemd udev

DESCRIPTION="DisplayLink USB Graphics Software"
HOMEPAGE="http://www.displaylink.com/downloads/ubuntu"
SRC_URI="${P}.zip"
LICENSE="DisplayLink-EULA"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 "
IUSE="systemd"
PV_EXTRA="59.185"

QA_PREBUILT="/opt/displaylink/DisplayLinkManager"
RESTRICT="fetch bindist"

DEPEND="app-admin/chrpath
	app-arch/unzip"
RDEPEND=">=sys-devel/gcc-6.5.0
	=x11-drivers/evdi-1.12*
	virtual/libusb:1
	>=x11-base/xorg-server-1.17.0
	!systemd? ( sys-auth/elogind )"

pkg_nofetch() {
	einfo "Please download DisplayLink USB Graphics Software for Ubuntu${PV}-EXE.zip from"
	einfo "http://www.displaylink.com/downloads/ubuntu"
	einfo "and rename it to ${P}.zip"
}

src_unpack() {
	default
	sh ./"${PN}-${PV}-${PV_EXTRA}".run --noexec --target "${P}"
}

src_install() {
	if [[ "${ARCH}" == "arm" ]]; then
		DLM="${S}/arm-linux-gnueabihf/DisplayLinkManager"
	else
		#if [[ ( $(gcc-major-version) -eq 9 && $(gcc-minor-version) -ge 2 ) || $(gcc-major-version) -gt 9 ]]; then
		MY_UBUNTU_VERSION=1604
		#else
		#	MY_UBUNTU_VERSION=1404
		#fi
		einfo "Using package for Ubuntu ${MY_UBUNTU_VERSION} based on your gcc version: $(gcc-version)"

		case "${ARCH}" in
			amd64)	MY_ARCH="x64" ;;
			*)		MY_ARCH="${ARCH}" ;;
		esac
		DLM="${S}/${MY_ARCH}-ubuntu-${MY_UBUNTU_VERSION}/DisplayLinkManager"
	fi

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
	einfo "The DisplayLinkManager Init is now called dlm"
	einfo ""
	einfo "You should be able to use xrandr as follows:"
	einfo "xrandr --setprovideroutputsource 1 0"
	einfo "Repeat for more screens, like:"
	einfo "xrandr --setprovideroutputsource 2 0"
	einfo "Then, you can use xrandr or GUI tools like arandr to configure the screens, e.g."
	einfo "xrandr --output DVI-1-0 --auto"
}
