EAPI=8

inherit meson

DESCRIPTION="Screen freezing program for wayland"
HOMEPAGE="https://github.com/heather7283/frzscr"

inherit git-r3
EGIT_REPO_URI="https://github.com/heather7283/frzscr.git"

LICENSE="GPL-3+"
SLOT="0"

RDEPEND="
	dev-libs/wayland
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
    dev-build/ninja
    dev-build/meson
	dev-util/wayland-scanner
"

