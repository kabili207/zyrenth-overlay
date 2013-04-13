# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils distutils

DESCRIPTION="Tools to manage Hotkeys, WLAN, Bluetooth and other features of an Asus EeePC."
HOMEPAGE="http://greg.geekmind.org/eee-control/"
SRC_URI="http://greg.geekmind.org/eee-control/src/${P}.tar.gz
	http://www.zirona.com/misc/code/eee-control/${P}-gentooinit
	http://www.zirona.com/misc/code/eee-control/${P}-dbus-plugdev.patch
	http://www.zirona.com/misc/code/eee-control/${P}-actions.py.patch"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"

IUSE="gnome gtk kde +xosd"

RDEPEND="gtk? ( dev-python/pygtk dev-python/gconf-python )
	gnome? ( gnome-extra/gnome-power-manager )
	xosd? ( x11-libs/xosd )
	dev-python/pyalsaaudio
	dev-python/notify-python
	dev-python/dbus-python
	>=sys-apps/i2c-tools-3.0.2[python]
	kde? ( x11-themes/gtk-engines-qt )"

src_unpack() {
	unpack ${A}
}

src_compile() {
	cd "${S}"
	python setup.py build || die "Building the package failed!"
}

src_install() {
	cd "${S}"
	epatch ${DISTDIR}/${P}-dbus-plugdev.patch || die "Patching DBus config failed."
	epatch ${DISTDIR}/${P}-actions.py.patch || die "Patching actions.py failed."
	python setup.py install --root ${D}  || die "The base installation routine failed!"
	newinitd  ${DISTDIR}/${P}-gentooinit eee-control || die "Inserting init script failed."
	dodoc doc/README || die "Installing documentation failed."
}

pkg_postinst() {
	
	ewarn "Before you start eee-control daemon, it is vitally important to remove/disable"
	ewarn "all EeePC related stuff from /etc/acpi and restart acpid."
	echo
	ewarn "A 2.6.27 kernel or higher is required, with full support for the EeePC hardware."
	ewarn "Go to http://www.zirona.com/misc/code/eee-control/eeepc-kernelconfig for a"
	ewarn 'sample .config (use with `make oldconfig`).'
	echo
	ewarn "To have the eee-control daemon start at boot, add it to the default runlevel:"
	ewarn '`rc-update add eee-control default`'
	echo
	ewarn "To use the eee-control-tray in your desktop environment as regular user, add"
	ewarn "yourself to the plugdev group. To have it auto-started with your DE, create an"
	ewarn "Autostart entry for it."
	echo
	ewarn "Please visit http://forums.gentoo.org/viewtopic-p-5280572.html to share your"
	ewarn "experience with this ebuild."
	echo

	if ! use gnome; then
		elog "If you want eee-control to use features of the gnome-power-manager, please"
		elog "emerge gnome-extra/gnome-power-manager (if you haven't already), or re-emerge"
		elog "this package with the gnome USE flag enabled."
	fi
}
