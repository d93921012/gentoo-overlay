# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils desktop

DESCRIPTION="A viewer for .stl files"
HOMEPAGE="http://www.mattkeeter.com/projects/fstl/"
SRC_URI="https://github.com/mkeeter/${PN}/archive/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="keyring"

# gconf is deprecated.
# DEPEND="gnome-base/gconf:2"
RDEPEND="
	${DEPEND}
	dev-qt/qtcore:5
	dev-qt/qtgui:5
"

#S=${WORKDIR}/${P/_/.}
#S=${WORKDIR}

#src_prepare() {
#	default
	# echo "${PV}" > ${S}/VERSION.gcin
#}

src_configure() {
	cd "${srcdir}"
	mkdir build
	cd build
	cmake ..
}

src_compile() {
	cd "${srcdir}"
	cd build
	emake CC="$(tc-getCC)" || die
}

src_install() {
	exeinto /usr/bin
	doexe build/${PN}

	# Install Icons
	newicon "${FILESDIR}/fstl_128x128x32.png" "${PN}.png" || die
	newicon -s 128 "${FILESDIR}/fstl_128x128x32.png" "${PN}.png" || di

	# install-xattr doesnt approve using domenu or doins from FILESDIR
	cp "${FILESDIR}"/${PN}.desktop "${S}"
	domenu "${S}"/${PN}.desktop
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

