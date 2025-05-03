EAPI=8

inherit meson

DESCRIPTION="xdg-desktop-portal backend (termfilechooser)"
HOMEPAGE="https://github.com/heather7283/xdg-desktop-portal-termfilechooser"

inherit git-r3
EGIT_REPO_URI="https://github.com/heather7283/xdg-desktop-portal-termfilechooser.git"

LICENSE="MIT"
SLOT="0"
IUSE="elogind systemd examples"
REQUIRED_USE="?? ( elogind systemd )"

RDEPEND="
	|| (
		systemd? ( >=sys-apps/systemd-237 )
		elogind? ( >=sys-auth/elogind-237 )
		sys-libs/basu
	)
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
"

src_configure() {
	local emesonargs=(
		$(meson_feature systemd)
		$(meson_use examples)
	)

	if use systemd; then
		emesonargs+=('-Dsd-bus-provider=libsystemd')
	elif use elogind; then
		emesonargs+=('-Dsd-bus-provider=libelogind')
	else
		emesonargs+=('-Dsd-bus-provider=basu')
	fi

	meson_src_configure
}

