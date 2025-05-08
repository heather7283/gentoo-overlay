EAPI=8

inherit meson

DESCRIPTION="isatty() wrapper"
HOMEPAGE="https://github.com/heather7283/yestty"

inherit git-r3
EGIT_REPO_URI="https://github.com/heather7283/yestty.git"

LICENSE="MIT"
SLOT="0"

RDEPEND=""
DEPEND=""
BDEPEND="
    dev-build/ninja
    dev-build/meson
"

