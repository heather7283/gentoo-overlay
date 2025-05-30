EAPI=8

inherit meson

DESCRIPTION="CLI TODO app"
HOMEPAGE="https://github.com/heather7283/todo"

inherit git-r3
EGIT_REPO_URI="https://github.com/heather7283/todo.git"

LICENSE="GPL-3+"
SLOT="0"

RDEPEND=""
DEPEND=""
BDEPEND="
    dev-build/ninja
    dev-build/meson
"

