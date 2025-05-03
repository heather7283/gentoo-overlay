EAPI=8

inherit cmake

DESCRIPTION="Simple and flexbile QtQuick based desktop shell toolkit."
HOMEPAGE="https://quickshell.outfoxxed.me/"

EGIT_REPO_URI="https://git.outfoxxed.me/quickshell/quickshell.git"
inherit git-r3

LICENSE="LGPL-3"
SLOT="0"

IUSE="-crash-reporter +jemalloc +sockets +wayland +x11 -pipewire -systray -mpris -pam -hyprland -i3-sway"
REQUIRED_USE="hyprland? ( wayland )"

RDEPEND="
	>=dev-qt/qtbase-6.6
	>=dev-qt/qtdeclarative-6.6
	>=dev-qt/qtsvg-6.6

	dev-cpp/cli11

	crash-reporter? ( dev-util/breakpad )
	jemalloc? ( dev-libs/jemalloc )
	wayland? (
		>=dev-qt/qtwayland-6.6
		dev-libs/wayland
	)
	x11? ( x11-libs/libxcb )
	pipewire? ( media-video/pipewire )
	systray? ( dev-qt/qtbase[dbus] )
	mpris? ( dev-qt/qtbase[dbus] )
	pam? ( sys-libs/pam )
"

BDEPEND="
	dev-build/cmake
	dev-build/ninja
	virtual/pkgconfig
	dev-util/spirv-tools

	>=dev-qt/qtshadertools-6.6

	wayland? (
		dev-util/wayland-scanner
		dev-libs/wayland-protocols
	)
"

DEPEND="${RDEPEND}"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DDISTRIBUTOR="Gentoo ebuild by heather7283"
		-DDISTRIBUTOR_DEBUGINFO_AVAILABLE=NO
		-DCMAKE_BUILD_TYPE=RelWithDebInfo
		-DCMAKE_INSTALL_PREFIX=/usr
		-DINSTALL_QML_PREFIX=lib64/qt6/qml/

		-DCRASH_REPORTER=$(usex crash-reporter)
		-DUSE_JEMALLOC=$(usex jemalloc)
		-DSOCKETS=$(usex sockets)

		-DHYPRLAND=$(usex hyprland)
		-DHYPRLAND_GLOBAL_SHORTCUTS=$(usex hyprland)
		-DHYPRLAND_FOCUS_GRAB=$(usex hyprland)

		-DI3=$(usex i3-sway)
		-DI3_IPC=$(usex i3-sway)

		-DWAYLAND=$(usex wayland)
		-DWAYLAND_WLR_LAYERSHELL=$(usex wayland)
		-DWAYLAND_SESSION_LOCK=$(usex wayland)
		-DWAYLAND_TOPLEVEL_MANAGEMENT=$(usex wayland)

		-DSERVICE_STATUS_NOTIFIER=$(usex systray)
		-DSERVICE_PIPEWIRE=$(usex pipewire)
		-DSERVICE_MPRIS=$(usex mpris)
		-DSERVICE_PAM=$(usex pam)
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

src_install() {
	cmake_src_install
}

