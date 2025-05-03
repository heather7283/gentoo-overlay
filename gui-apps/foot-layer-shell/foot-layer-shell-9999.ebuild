EAPI=8

inherit meson xdg

DESCRIPTION="Fork of foot with wlr-layer-shell support"
HOMEPAGE="https://codeberg.org/heather7283/foot-layer-shell"

inherit git-r3
EGIT_REPO_URI="https://codeberg.org/heather7283/foot-layer-shell.git"

LICENSE="MIT"
SLOT="0"
IUSE="+grapheme-clustering +ime pgo"

COMMON_DEPEND="
	dev-libs/wayland
	media-libs/fcft
	media-libs/fontconfig
	x11-libs/libxkbcommon
	x11-libs/pixman
	grapheme-clustering? (
		dev-libs/libutf8proc:=
		media-libs/fcft[harfbuzz]
	)
    pgo? (
        >=gui-wm/sway-1.7
    )
"
DEPEND="
	${COMMON_DEPEND}
	>=dev-libs/tllist-1.1.0
	>=dev-libs/wayland-protocols-1.32
"
RDEPEND="
	${COMMON_DEPEND}
    >=sys-libs/ncurses-6.3[-minimal]
"
BDEPEND="
	dev-util/wayland-scanner
"

BUILD_DIR="${S}/build"

src_prepare() {
	default
	# disable the systemd dep, we install the unit file manually
	sed -i "s/systemd', required: false)$/', required: false)/" "${S}"/meson.build || die
}

src_configure() {
	local emesonargs=(
		$(meson_feature grapheme-clustering)
        $(meson_use ime)
		-Dterminfo=disabled
		-Dtests=false
		-Dthemes=false
	)
	meson_src_configure -Ddefault-terminfo=foot -Dterminfo-base-name=foot-extra
}

src_compile() {
    if use pgo; then
        ./pgo/pgo.sh full-headless-sway "${S}" "${BUILD_DIR}" \
            --prefix=/usr \
            --wrap-mode=nodownload || die
    else
        meson_src_compile
    fi
}

src_install() {
	meson_src_install
	rm -rv "${ED}/usr/share/" || die
	rm -rv "${ED}/etc/" || die
}

pkg_postinst() {
	elog "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	elog ""
	elog "NOTE: This package does NOT install terminfo, manpages, etc..."
	elog "It is meant to be installed alongside a normal foot package."
	elog ""
	elog "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
}

