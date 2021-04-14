"""deps.bzl contains macros for setting up all repository dependencies."""
load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")
load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")
load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@io_bazel_rules_go//extras:embed_data_deps.bzl", "go_embed_data_dependencies")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")


def rules_mgit_setup():
    """Setup all rules_mgit dependencies."""
    bazel_skylib_workspace()
    rules_pkg_dependencies()
    rules_proto_dependencies()
    rules_proto_toolchains()
    go_rules_dependencies()
    go_register_toolchains(
        nogo = "@rules_mgit//internal/nogo",
        version = "1.16.1",
    )
    go_embed_data_dependencies()
    gazelle_dependencies()
