# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit eutils versionator

RESTRICT="strip"

DESCRIPTION="Official desktop version of Telegram messaging app"
HOMEPAGE="https://tdesktop.com/"
SRC_URI="
	amd64?	( https://updates.tdesktop.com/tlinux/tsetup.${PV}.tar.xz )
	x86?	( https://updates.tdesktop.com/tlinux32/tsetup32.${PV}.tar.xz )"

RESTRICT="mirror"
LICENSE="GPL-3"
IUSE=""
KEYWORDS="~x86 ~amd64"
INSTALL_DIR="/opt/telegram"
SLOT="0"
DEPEND=""
RDEPEND="${DEPEND}"
S="${WORKDIR}/Telegram"

src_unpack() {
	unpack ${A}
	cd ${S}
	wget "https://raw.githubusercontent.com/telegramdesktop/tdesktop/master/Telegram/SourceFiles/art/icon256.png" || die
}

src_install() {
    insinto "${INSTALL_DIR}"
    doins -r Telegram Updater

    fperms 777 ${INSTALL_DIR}/Telegram
    fperms 777 ${INSTALL_DIR}/Updater

    make_wrapper "${PN}" "${INSTALL_DIR}/Telegram"
	newicon icon256.png "${PN}.png"
    make_desktop_entry "${PN}" "Telegram" "${PN}"
}

