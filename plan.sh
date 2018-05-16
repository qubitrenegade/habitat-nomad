# See full docs at https://www.habitat.sh/docs/reference/plan-syntax/
pkg_name=nomad
pkg_origin=qubitrenegade
pkg_version="0.8.3"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MPL-2.0")
pkg_source="https://releases.hashicorp.com/${pkg_name}/${pkg_version}/${pkg_name}_${pkg_version}_linux_amd64.zip"
pkg_filename="${pkg_name}-${pkg_version}_linux_amd64.zip"
pkg_description="A tool for managing a cluster of machines and running applications on them; https://github.com/qubitrenegade/habitat-nomad"
pkg_upstream_url="https://www.nomadproject.io"
pkg_shasum="c7faaee8fad0f6a74df01b9283253ee565f85791adca1d6a38462e0387dee175"
pkg_deps=()
pkg_build_deps=(core/unzip)
pkg_bin_dirs=(bin)

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

# unzip our package into ${pkg_name}-${pkg_version} instead of just ${pkg_name}
do_unpack() {
  cd "${HAB_CACHE_SRC_PATH}" || exit
  unzip ${pkg_filename} -d "${pkg_name}-${pkg_version}"
}


# Since we have a precompiled binary, skip trying to compile it
do_build() {
  return 0
}

do_install() {
  install -D nomad "${pkg_prefix}/bin/nomad"
}
