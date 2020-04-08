pkg_name=certbot
pkg_origin=rsertelon
pkg_maintainer='Romain Sertelon <romain@sertelon.fr>'
pkg_license='Apache-2.0'
pkg_upstream_url='https://certbot.eff.org'
pkg_description='The Certbot LetsEncrypt client.'
pkg_deps=(
  'core/bash'
  'core/findutils'
  'core/python'
)
pkg_plugins=(
  'dns-rfc2136'
)
pkg_bin_dirs=(bin)

pkg_version() {
  pip --disable-pip-version-check search "$pkg_name" \
    | grep "^$pkg_name " \
    | cut -d'(' -f2 \
    | cut -d')' -f1
}

do_before() {
  update_pkg_version
}

do_prepare() {
  python -m venv "$pkg_prefix"
  source "${pkg_prefix}/bin/activate"
}

do_build() {
  return 0
}

do_install() {
  for plugin in ${pkg_plugins[@]}
  do
    pip --disable-pip-version-check install "$pkg_name-$plugin==$pkg_version"
  done
}

do_strip() {
  return 0
}