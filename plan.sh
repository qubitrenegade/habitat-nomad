# See full docs at https://www.habitat.sh/docs/reference/plan-syntax/
pkg_name=nomad
pkg_origin=qubitrenegade
pkg_version="0.8.3"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MPL-2.0")
pkg_source="https://github.com/hashicorp/${pkg_name}/archive/v${pkg_version}.zip"
pkg_filename="${pkg_name}-${pkg_version}.zip"
pkg_description="A tool for managing a cluster of machines and running applications on them; https://github.com/qubitrenegade/habitat-nomad"
pkg_upstream_url="https://www.nomadproject.io"
pkg_shasum=0e4b7289d36b3a911fa6ccd4d7dd1cf9a6f25fcb94d562945106e264e4b01bee
# pkg_deps=(core/linux core/glibc)
pkg_deps=(qubitrenegade/consul-client)
pkg_build_deps=(core/unzip core/make qubitrenegade/go110 core/git core/pkg-config core/gcc)
pkg_bin_dirs=(bin)

# pkg_scaffolding=core/scaffolding-go
# pkg_source=https://github.com/hashicorp/nomad
# pkg_source="https://github.com/hashicorp/nomad/archive/v0.8.3.zip"

pkg_svc_user="root"
pkg_svc_group="$pkg_svc_user"

pkg_exports=(
  [host]=srv.address
  # [port]=srv.port
  # [ssl-port]=srv.ssl.port
)

# Optional.
# An array of `pkg_exports` keys containing default values for which ports that this package
# exposes. These values are used as sensible defaults for other tools. For example, when exporting
# a package to a container format.
# pkg_exposes=(port ssl-port)

pkg_binds_optional=(
  [consul]="host"
)

do_configure() {
  return 0
}

do_prepare() {
  return 0
}

# Since we have a precompiled binary, skip trying to compile it
do_build() {
  GOPATH=$(go env GOPATH)
  PATH=$PATH:${GOPATH}/bin
  SRCPATH=$GOPATH/src/github.com/hashicorp
  PKGPATH=${SRCPATH}/${pkg_name}
  mkdir -p $SRCPATH
  rm -rf ${PKGPATH}
  cp -r ${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version} ${PKGPATH}
  cd ${PKGPATH}
  make bootstrap
  make dev
}

do_install() {
  # attach
  install -D "${PKGPATH}/bin/${pkg_name}" "${pkg_prefix}/bin/${pkg_name}"
}
