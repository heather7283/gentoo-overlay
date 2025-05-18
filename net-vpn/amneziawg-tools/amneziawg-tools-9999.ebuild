EAPI=7

inherit linux-info bash-completion-r1 toolchain-funcs

DESCRIPTION="Tools for configuring Amnezia-WG"
HOMEPAGE="https://amnezia.org/"

inherit git-r3
EGIT_REPO_URI="https://github.com/amnezia-vpn/amneziawg-tools.git"

LICENSE="GPL-2"
SLOT="0"
IUSE="+awg-quick"

BDEPEND="virtual/pkgconfig"
DEPEND=""
RDEPEND="${DEPEND}
	awg-quick? (
		|| ( net-firewall/nftables net-firewall/iptables )
		virtual/resolvconf
	)
"

wg_quick_optional_config_nob() {
	CONFIG_CHECK="$CONFIG_CHECK ~$1"
	declare -g ERROR_$1="CONFIG_$1: This option is required for automatic routing of default routes inside of awg-quick(8), though it is not required for general WireGuard usage."
}

pkg_setup() {
	if use awg-quick; then
		wg_quick_optional_config_nob IP_ADVANCED_ROUTER
		wg_quick_optional_config_nob IP_MULTIPLE_TABLES
		wg_quick_optional_config_nob IPV6_MULTIPLE_TABLES
		if has_version net-firewall/nftables; then
			wg_quick_optional_config_nob NF_TABLES
			wg_quick_optional_config_nob NF_TABLES_IPV4
			wg_quick_optional_config_nob NF_TABLES_IPV6
			wg_quick_optional_config_nob NFT_CT
			wg_quick_optional_config_nob NFT_FIB
			wg_quick_optional_config_nob NFT_FIB_IPV4
			wg_quick_optional_config_nob NFT_FIB_IPV6
			wg_quick_optional_config_nob NF_CONNTRACK_MARK
		elif has_version net-firewall/iptables; then
			wg_quick_optional_config_nob NETFILTER_XTABLES
			wg_quick_optional_config_nob NETFILTER_XT_MARK
			wg_quick_optional_config_nob NETFILTER_XT_CONNMARK
			wg_quick_optional_config_nob NETFILTER_XT_MATCH_COMMENT
			wg_quick_optional_config_nob NETFILTER_XT_MATCH_ADDRTYPE
			wg_quick_optional_config_nob IP6_NF_RAW
			wg_quick_optional_config_nob IP_NF_RAW
			wg_quick_optional_config_nob IP6_NF_FILTER
			wg_quick_optional_config_nob IP_NF_FILTER
		fi
	fi
	get_version
	if [[ -f $KERNEL_DIR/include/uapi/linux/wireguard.h ]]; then
		CONFIG_CHECK="~AMNEZIAWG $CONFIG_CHECK"
		declare -g ERROR_AMNEZIAWG="CONFIG_AMNEZIAWG: This option is required for using AmneziaWG."
	fi
	linux-info_pkg_setup
}

src_compile() {
	emake RUNSTATEDIR="${EPREFIX}/run" -C src CC="$(tc-getCC)" LD="$(tc-getLD)"
}

src_install() {
	dodoc README.md
	dodoc -r contrib
	emake \
		WITH_BASHCOMPLETION=yes \
		WITH_SYSTEMDUNITS=no \
		WITH_WGQUICK=$(usex awg-quick) \
		DESTDIR="${D}" \
		BASHCOMPDIR="$(get_bashcompdir)" \
		PREFIX="${EPREFIX}/usr" \
		-C src install
}

