EAPI=8

inherit cmake

DESCRIPTION="A responsive and customizable clock, timer, and stopwatch for the terminal."
HOMEPAGE="https://octobanana.com/software/peaclock"

EGIT_REPO_URI="https://github.com/octobanana/peaclock.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-libs/icu
"

BDEPEND="
	dev-build/cmake
	dev-build/ninja
"

DEPEND="${RDEPEND}"

