# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
ROS_REPO_URI="https://github.com/ros/roscpp_core"
KEYWORDS="~amd64 ~arm"
ROS_SUBDIR=${PN}

inherit ros-catkin

DESCRIPTION="Time and Duration implementations for C++ libraries"
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="
	dev-libs/boost:=[threads]
	dev-ros/cpp_common
"
DEPEND="${RDEPEND}
	test? ( dev-cpp/gtest )
"
