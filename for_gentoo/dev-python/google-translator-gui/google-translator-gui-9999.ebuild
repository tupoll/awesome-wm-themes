

# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 


DESCRIPTION="Google translate gui"
HOMEPAGE="https://github.com/delvin-fil/Google-translator-GUI.git"

EGIT_REPO_URI="https://github.com/delvin-fil/Google-translator-GUI.git"
KEYWORDS="~amd64"


LICENSE="MIT"
SLOT="0/11"
IUSE="gtk"
REQUIRED_USE=""

DEPEND="dev-python/requests
       dev-python/pygobject"
       
RDEPEND=""

S="${WORKDIR}/google-translator-gui-9999"

src_prepare() {
    default     
    mv -f "${S}/translatorgtk.py" "${S}/googletrans-gtk" || die       
    sed -i -e '1a #!/usr/bin/env python' "${S}/googletrans-gtk" || die
    sed -i -e '1d' "${S}/googletrans-gtk" || die
}

src_install() {
    dodir /opt/gtrans
	cp -R "${S}" /opt/gtrans || die 	
	dobin "${FILESDIR}/googletrans-gtk" || die
  einfo "Please remove unnecessary files from the /opt/gtans directory!"
}

