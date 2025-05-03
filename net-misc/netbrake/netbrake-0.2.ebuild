EAPI=8

inherit flag-o-matic

DESCRIPTION="Utility to limit the bandwidth used by a process"
HOMEPAGE="http://www.hping.org/netbrake/"

# The website was 404ing
SRC_URI="http://web.archive.org/web/20151018190016/http://www.hping.org/netbrake/netbrake-0.2.tar.gz"
S="${WORKDIR}/netbrake"

LICENSE="X11"

SLOT="0"

IUSE="httpfs"

PATCHES=(
	"${FILESDIR}/x86_64.patch"
)

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

