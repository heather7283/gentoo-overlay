EAPI=8

inherit meson

DESCRIPTION="TUI volume control app for pipewire"
HOMEPAGE="https://github.com/heather7283/pipemixer"

inherit git-r3
EGIT_REPO_URI="https://github.com/heather7283/pipemixer.git"

LICENSE="GPL-3+"
SLOT="0"

RDEPEND="
	sys-libs/ncurses
	media-video/pipewire
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
    dev-build/ninja
    dev-build/meson
"

