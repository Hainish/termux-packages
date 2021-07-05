TERMUX_PKG_HOMEPAGE=https://gohugo.io/
TERMUX_PKG_DESCRIPTION="A fast and flexible static site generator"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.84.4
TERMUX_PKG_SRCURL=https://github.com/gohugoio/hugo/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=d8711de4b34ef602efa4805648efcc5c8b3881138db85b16efc025b5b08fb209
TERMUX_PKG_DEPENDS="libc++"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	termux_setup_golang
	termux_go_get
	go build \
		-o hugo \
		main.go
}

termux_step_make_install() {
	install -Dm700 -t "$TERMUX_PREFIX"/bin "$TERMUX_PKG_SRCDIR"/hugo
	mkdir -p $TERMUX_PREFIX/share/{bash-completion/completions,man/man1}

	./hugo gen autocomplete \
		--completionfile=$TERMUX_PREFIX/share/bash-completion/completions/hugo
	./hugo gen man \
		--dir=$TERMUX_PREFIX/share/man/man1/
}
