# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit eutils

DESCRIPTION="Official desktop version of Telegram messaging app"
HOMEPAGE="https://desktop.telegram.org/"
SRC_URI="
	amd64?	( https://updates.tdesktop.com/tlinux/tsetup.${PV}.tar.xz )
	x86?	( https://updates.tdesktop.com/tlinux32/tsetup32.${PV}.tar.xz )"

RESTRICT="mirror"
LICENSE="GPL-3"
IUSE=""
KEYWORDS="x86 amd64"
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
	exeinto "/usr/bin"
	newexe Telegram "${PN}"
	newicon icon256.png "${PN}.png"
	make_desktop_entry "${PN}" "Telegram" "${PN}"
}

