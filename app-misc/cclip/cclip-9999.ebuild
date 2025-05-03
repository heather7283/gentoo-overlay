EAPI=8

inherit meson

DESCRIPTION="Clipboard manager for wayland"
HOMEPAGE="https://github.com/heather7283/cclip"

inherit git-r3
EGIT_REPO_URI="https://github.com/heather7283/cclip.git"

LICENSE="GPL-3+"
SLOT="0"
IUSE="man"

RDEPEND="
	dev-db/sqlite
	dev-libs/wayland
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
    dev-build/ninja
    dev-build/meson
	dev-util/wayland-scanner
	man? ( app-text/scdoc )
"

src_configure() {
	local emesonargs=(
		$(meson_use man)
	)
	meson_src_configure
}

