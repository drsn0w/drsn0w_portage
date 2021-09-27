# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1 udev

DESCRIPTION="Cross-platform tool and drivers for liquid coolers and other devices"
HOMEPAGE="https://github.com/liquidctl/liquidctl"
SRC_URI="https://github.com/liquidctl/liquidctl/releases/download/v${PV}/${P}.tar.gz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/colorlog[${PYTHON_USEDEP}]
	dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/hidapi[${PYTHON_USEDEP}]
	dev-python/pyusb[${PYTHON_USEDEP}]
	sys-apps/i2c-tools[${PYTHON_USEDEP},python]
"

distutils_enable_tests pytest

src_test() {
	# Without this variable, it attempts to write to /var/run and fails
	XDG_RUNTIME_DIR="${T}/xdg" distutils-r1_src_test || die
}

python_install_all() {
	distutils-r1_python_install_all
	dodoc docs/*.md || die
	dodoc -r docs/linux/
	udev_dorules extra/linux/71-liquidctl.rules
}