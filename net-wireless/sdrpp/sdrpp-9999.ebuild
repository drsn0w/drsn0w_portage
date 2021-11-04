
EAPI=7

CMAKE_MAKEFILE_GENERATOR="emake"

inherit cmake-utils

DESCRIPTION="SDR++ is a cross-platform and open source SDR software with the aim of being bloat free and simple to use."
HOMEPAGE="https://github.com/AlexandreRouma/SDRPlusPlus"

SLOT="0"
LICENSE="GPL-3"

IUSE="+rtlsdr soapysdr airspy plutosdr +audiosink"

#PATCHES=( "cmake-inestall.patch" )

DEPEND="sci-libs/fftw
    media-libs/glfw
    media-libs/glew
    sci-libs/volk
    rtlsdr? ( net-wireless/rtl-sdr )
    airspy? ( net-wireless/airspy )
    soapysdr? ( net-wireless/soapysdr )
    audiosink? ( media-libs/rtaudio )
    plutosdr? ( net-libs/libiio
        net-libs/libad9361-iio )"


if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/AlexandreRouma/SDRPlusPlus.git"
	inherit git-r3
else
	SRC_URI="https://github.com/AlexandreRouma/SDRPlusPlus.git"
	KEYWORDS="~amd64 ~arm ~x86"
fi



src_configure() {
    local mycmakeargs=(
        -DOPT_BUILD_AIRSPY_SOURCE=OFF
        -DOPT_BUILD_AIRSPYHF_SOURCE=OFF
        -DOPT_BUILD_SOAPY_SOURCE=OFF
        -DOPT_BUILD_HACKRF_SOURCE=OFF
        -DOPT_BUILD_PLUTOSDR_SOURCE=OFF
    )

    cmake-utils_src_configure
}

