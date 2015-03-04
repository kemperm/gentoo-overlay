# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="5"

inherit cmake-utils

DESCRIPTION="Helps with learning classical score notation. Mostly it is for guitarists, but it can be used for ear training as well."
HOMEPAGE="http://wspinell.altervista.org/qpitch/"
SRC_URI="mirror://sourceforge/${PN}/${P}-alpha-source.tar.bz2"
S=${WORKDIR}/${P}-alpha-source

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="jack pulseaudio debug"

DEPEND="
	>=dev-qt/qtcore-5.2:5
	>=dev-qt/qtgui-5.2:5
	>=dev-qt/qtwidgets-5.2:5
	>=dev-qt/qtprintsupport-5.2:5
	>=dev-qt/qtnetwork-5.2:5
	>=dev-qt/qtsvg-5.2:5
	media-libs/libogg
	media-libs/libvorbis
	sci-libs/fftw:3.0
	media-libs/libsoundtouch
	media-libs/alsa-lib
	jack? ( media-sound/jack-audio-connection-kit )
	pulseaudio? ( media-sound/pulseaudio )
"
RDEPEND="${DEPEND}"

DOCS=( README changes copyright )

src_configure() {
	mycmakeargs=(
		-DENABLE_UPDATER=OFF
		$(cmake-utils_use_enable jack JACK)
		$(cmake-utils_use_enable pulseaudio PULSEAUDIO)
	)

	cmake-utils_src_configure
}
