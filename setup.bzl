"""deps.bzl contains macros for setting up all repository dependencies."""
load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")
load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@io_bazel_rules_go//extras:embed_data_deps.bzl", "go_embed_data_dependencies")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies", "go_repository")
load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories="repositories")
load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps="deps")

def rules_mgit_setup():
    """Setup all rules_mgit dependencies."""
    bazel_skylib_workspace()
    rules_pkg_dependencies()
    go_rules_dependencies()
    go_register_toolchains(
        nogo = "@rules_mgit//internal/nogo",
        version = "1.17.1",
    )
    go_embed_data_dependencies()
    gazelle_dependencies()
    container_repositories()
    container_deps()

    # See https://github.com/bazelbuild/rules_docker/issues/1847
    _maybe(
        go_repository,
        name = "com_github_vdemeester_k8s_pkg_credentialprovider",
        importpath = "github.com/vdemeester/k8s-pkg-credentialprovider",
        sum = "h1:7Ajl3rjeYoB5V47jPknnLbyxYlhMXTTJiQsye5aT7f0=",
        version = "v1.21.0-1",
    )

def _maybe(rule, name, **kwargs):
    """Declares an external repository if it hasn't been declared already."""
    if name not in native.existing_rules():
        rule(name = name, **kwargs)
