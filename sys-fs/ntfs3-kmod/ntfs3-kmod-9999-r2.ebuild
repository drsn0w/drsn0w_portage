# Copyright 2021 drsn0w
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod flag-o-matic

DESCRIPTION="ntfs3 Linux kernel module by Paragon Software, maintained by rmnscnce"
HOMEPAGE="https://github.com/rmnscnce/ntfs3"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/LGA1150/ntfs3-oot.git"
	inherit git-r3
else
	SRC_URI="https://github.com/rmnscnce/ntfs3/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

pkg_setup() {

    linux-mod_pkg_setup
    # Check if kernel is greater than 5.14 / die if not
    kernel_is -ge 5 14 || die "Linux 5.14 or newer is required"

    MODULE_NAMES="ntfs3(fs:::)"
    BUILD_TARGETS="all"
    BUILD_PARAMS=" KVERSION=${KV_FULL} \
            V=1 \
            LINUX_SOURCE=\"${KERNEL_DIR}\" \
            KBUILD_OUTPUT=\"${KBUILD_OUTPUT}\" \
            USE_KBUILD=y MODINST=n RUNDM=n"


}





