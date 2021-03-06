# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

# Can go if we ever drop the "PEAR-" prefix.
MY_PN="${PN#PEAR-}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Detect violations of PHP code standards"
HOMEPAGE="https://github.com/squizlabs/PHP_CodeSniffer"
SRC_URI="https://github.com/squizlabs/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="test? ( >=dev-php/phpunit-4 )"
RDEPEND="dev-lang/php:*[cli,tokenizer,xmlwriter]"

# Can go if we ever drop the "PEAR-" prefix.
S="${WORKDIR}/${MY_P}"

DOCS=( CONTRIBUTING.md README.md )
src_install() {
	insinto "/usr/share/${PN}"
	doins -r CodeSniffer CodeSniffer.php

	# These load code via relative paths, so they have to be symlinked
	# and not dobin'd.
	exeinto "/usr/share/${PN}/scripts"
	for script in phpcbf phpcs; do
		doexe "scripts/${script}"
		dosym "/usr/share/${PN}/scripts/${script}" "/usr/bin/${script}"
	done

	einstalldocs
}

# The test suite isn't part of the tarball at the moment, keep an eye on
# https://github.com/squizlabs/PHP_CodeSniffer/issues/548
RESTRICT=test
src_test() {
	phpunit || die "test suite failed"
}
