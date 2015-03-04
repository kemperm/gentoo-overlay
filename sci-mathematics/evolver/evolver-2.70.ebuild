# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="The Surface Evolver is an interactive program for the modelling of liquid surfaces shaped by various forces and constraints"
HOMEPAGE="http://www.susqu.edu/brakke/evolver/evolver.html"
SRC_URI="http://www.susqu.edu/brakke/evolver/downloads/evolver-2.70.tar.gz"

RESTRICT="mirror"
LICENSE=""
IUSE="doc examples geomview opengl +metis threads"
KEYWORDS="amd64"
SLOT="0"
DEPEND="
	|| (
		opengl? (
			virtual/opengl
			media-libs/freeglut
		)
		x11-libs/libX11
	)
	metis? ( sci-libs/metis )
"
RDEPEND="
	${DEPEND}
	geomview? ( sci-mathematics/geomview )
"

REQUIRED_USE="
	opengl? ( threads )
"

S="${WORKDIR}"

src_prepare() {
	# conflicts with parallel make
	sed -i -e 's:rm \*\.o || true::' src/Makefile || die
}

src_compile() {
	CFLAGS+=" -DLINUX -DOOGL"
	export GRAPH=""
	export GRAPHLIB=""
	if use opengl ; then
		GRAPH="glutgraph.o"
		GRAPHLIB="-lGL -lGLU -lglut -lpthread"
	else
		GRAPH="xgraph.o"
		GRAPHLIB="-L/usr/X11R6/lib -lX11"
	fi
	if use threads ; then
		CFLAGS+=" -DPTHREADS"
		GRAPHLIB+=" -lpthread"
	fi
	if use metis ; then
		CFLAGS+=" -DMETIS -I/usr/include/metis"
		GRAPHLIB+=" -lmetis"
	fi
#	CFLAGS+="-DMAXCOORD=10"
	cd src
	default
}

src_install() {
	doman evolver.1
    dobin src/evolver
	dodoc README.unix.txt
	local EVOLVERPATH=""
	if use doc ; then
		dohtml -A txt,fe -r doc/*
		dodoc manual270.pdf
		EVOLVERPATH+="/usr/share/doc/${PF}/html"
	fi
	if use examples ; then
		docinto examples
		docompress -x /usr/share/doc/${PF}/examples
		dodoc -r fe/*
		EVOLVERPATH+=":/usr/share/doc/${PF}/examples"
	fi
	if [[ ! -z "${EVOLVERPATH}" ]] ; then
		echo "EVOLVERPATH=${EVOLVERPATH}" > "${T}/90${PN}"
		doenvd "${T}/90${PN}"
	fi

}

