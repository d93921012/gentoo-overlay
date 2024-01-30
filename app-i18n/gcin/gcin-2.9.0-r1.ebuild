# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Another Traditional Chinese IM."
HOMEPAGE="http://hyperrate.com/dir.php?eid=67"
SRC_URI="http://hyperrate.com/gcin-source/${P/_/.}.tar.xz
	chinese-sound? ( http://ftp.twaren.net/local-distfiles/gcin/ogg.tgz )"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="filter-nobopomofo chinese-sound anthy chewing gtk3 qt5"

DEPEND=">=x11-libs/gtk+-2
	anthy? ( >=app-i18n/anthy-9100 )
	chewing? ( dev-libs/libchewing )
	gtk3? ( x11-libs/gtk+:3 )
	qt5? ( dev-qt/qtcore:5 dev-qt/qtgui:5 )"
#   已經沒有 qt4 了
#	qt4? ( dev-qt/qtcore:4 dev-qt/qtgui:4 )
RDEPEND="${DEPEND}
	chinese-sound? ( media-sound/vorbis-tools[ogg123] )"
DEPEND="${DEPEND}
	dev-util/pkgconf
	sys-devel/gettext"

RESTRICT="mirror"
S=${WORKDIR}/${P/_/.}

src_prepare() {
	default
	echo "${PV}" > ${S}/VERSION.gcin
}

src_configure() {
	econf --use_i18n=Y \
		--use_tsin=Y \
		--use_qt3=N \
		--use_qt4=N \
		$(! use anthy && echo --use_anthy=N ) \
		$(! use chewing && echo --use_chewing=N ) \
		$(! use qt5 && echo --use_qt5=N ) \
		$(! use gtk3 && echo --use_gtk3=N )
}

src_compile() {
	filter-ldflags "-Wl,--as-needed"
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use filter-nobopomofo ; then
		insinto /usr/share/pixmaps/gcin
		doins "${FILESDIR}"/nobopomofo/{SS1135_ST,SS1208_DT}.jpg || die
		exeinto /usr/share/gcin/script
		doexe "${FILESDIR}"/nobopomofo/gcin-filter-nobopomofo || die
		doenvd "${FILESDIR}"/nobopomofo/99gcin-filter-nobopomofo || die
	fi

	if use chinese-sound ; then
		insinto /usr/share/${PN}
		doins -r "${WORKDIR}"/ogg || die
	fi
}

update_gtk_immodules() {
	if [ -x "${EPREFIX}/usr/bin/gtk-query-immodules-2.0" ] ; then
		"${EPREFIX}/usr/bin/gtk-query-immodules-2.0"  --update-cache
	fi
	if [ -x "${EPREFIX}/usr/bin/gtk-query-immodules-3.0" ] ; then
		"${EPREFIX}/usr/bin/gtk-query-immodules-3.0"  --update-cache
	fi
}

pkg_postinst() {
	update_gtk_immodules
	#gtk_icon_cache_update
    gtk-update-icon-cache
}

pkg_postrm() {
	update_gtk_immodules
	#gtk_icon_cache_update
	gtk-update-icon-cache
}
