EAPI=8

inherit flag-o-matic

DESCRIPTION="Utility to limit the bandwidth used by a process"
HOMEPAGE="http://www.hping.org/netbrake/"

S="${WORKDIR}/netbrake"

LICENSE="X11"

SLOT="0"

IUSE="httpfs"

PATCHES=(
	"${FILESDIR}/x86_64.patch"
	"${FILESDIR}/makefile.patch"
)

src_unpack() {
	unpack "${FILESDIR}/netbrake-0.2.tar.gz"
}

src_configure() {
	if use httpfs; then
		printf "y\n/usr/lib64\n/usr/bin\n" | ./configure
	else
		printf "n\n/usr/lib64\n/usr/bin\n" | ./configure
	fi
}

src_compile() {
	append-flags '-fPIC'
	emake -e
}

src_install() {
	dobin "${S}/netbrake"
	dolib.so "${S}/libnetbrake.so.0.1"
}

