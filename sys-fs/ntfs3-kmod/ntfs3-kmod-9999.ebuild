# Copyright 2021 drsn0w
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools linux-mod flag-o-matic

DESCRIPTION="ntfs3 Linux kernel module by Paragon Software, maintained by rmnscnce"
HOMEPAGE="https://github.com/rmnscnce/ntfs3"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/rmnscnce/ntfs3.git"
	inherit git-r3
else
	SRC_URI="https://github.com/rmnscnce/ntfs3/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

pkg_setup() {
    # Check if kernel is greater than 5.14 / die if not
    kernel_is -ge 5 14 || die "Linux 5.14 or newer is required"

    MODULE_NAMES="ntfs3(fs:::)"

    linux-mod_pkg_setup
}

src_prepare() {
    default
}

src_configure() {
    set_arch_to_kernel
    strip-flags
    filter-ldflags -Wl,*
}

src_compile() {
    set_arch_to_kernel
    #linux-mod_src_compile
    emake
}

src_install() {
    set_arch_to_kernel

	myemakeargs+=(
		DEPMOD=:
		DESTDIR="${D}"
		MDIR="${D}/lib/modules/${KV_FULL}" # lib/modules/<kver> added by KBUILD
	)

    linux-mod_src_install

    #emake "${myemakeargs[@]}" install
}

pkg_postinst() {
    linux-mod_pkg_postinst
}