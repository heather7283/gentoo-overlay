EAPI=8

inherit meson

DESCRIPTION="ScreenShot Editor"
HOMEPAGE="https://github.com/heather7283/ssedit"

inherit git-r3
EGIT_REPO_URI="https://github.com/heather7283/ssedit.git"

LICENSE="GPL-3+"
SLOT="0"
IUSE="jpeg jpegxl png"
REQUIRED_USE="|| ( jpeg jpegxl png )"

RDEPEND="
	media-libs/glfw[wayland]
	virtual/opengl
	media-libs/glew

	jpegxl? ( media-libs/libjxl )
	jpeg? ( media-libs/libjpeg-turbo )
	png? ( media-libs/libspng )

	gui-apps/wl-clipboard
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
    dev-build/ninja
    dev-build/meson
	media-gfx/fontforge
"

src_configure() {
	local emesonargs=(
		$(meson_feature jpegxl)
		$(meson_feature jpeg)
		$(meson_feature png)
	)
	meson_src_configure
}

