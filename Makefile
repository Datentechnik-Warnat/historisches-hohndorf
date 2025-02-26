dev:
	hugo server --buildDrafts

build:
	hugo

install:
	wget https://github.com/gohugoio/hugo/releases/download/v0.144.2/hugo_extended_withdeploy_0.144.2_linux-amd64.deb -O hugo.deb && sudo dpkg -i hugo.deb