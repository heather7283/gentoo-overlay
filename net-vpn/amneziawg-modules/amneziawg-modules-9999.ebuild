EAPI=8

inherit linux-mod-r1

DESCRIPTION="AmneziaWG Linux kernel module"
HOMEPAGE="https://amnezia.org/"

inherit git-r3
EGIT_REPO_URI="https://github.com/amnezia-vpn/amneziawg-linux-kernel-module.git"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

CONFIG_CHECK="NET INET NET_UDP_TUNNEL CRYPTO_ALGAPI"

pkg_setup() {
	linux-mod-r1_pkg_setup
}

src_compile() {
	use debug && MODULES_MAKEARGS+=( CONFIG_AMNEZIAWG_DEBUG=y )
	MODULES_MAKEARGS+=( KERNELDIR=${KV_OUT_DIR} )

	cd src
	ln -vs "${KV_OUT_DIR}" kernel
	emake "${MODULES_MAKEARGS[@]}"
}

src_install() {
	cd src
    emake "${MODULES_MAKEARGS[@]}" INSTALL_MOD_PATH="${ED}" install
    modules_post_process
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst
	local old new
	if [[ $(uname -r) != "${KV_FULL}" ]]; then
		ewarn
		ewarn "You have just built AmneziaWG for kernel ${KV_FULL}, yet the currently running"
		ewarn "kernel is $(uname -r). If you intend to use this AmneziaWG module on the currently"
		ewarn "running machine, you will first need to reboot it into the kernel ${KV_FULL}, for"
		ewarn "which this module was built."
		ewarn
	fi
}
