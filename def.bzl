"""def.bzl contains public definitions for rules_mgit."""

load("@bazel_gazelle//:def.bzl", "gazelle")
load("@rules_mgit//internal/nogo:nogo.bzl", "nogo_deps")
load("@io_bazel_rules_go//go:def.bzl", "nogo")

def mgit_repo_rules(go_prefix):
    """Macro for defining commonly used repository wide rules like Gazelle."""
    gazelle(
        name = "gazelle",
        command = "fix",
        prefix = go_prefix,
    )
    gazelle(
        name = "gazelle-update-repos",
        args = [
            "-from_file=go.mod",
            "-to_macro=go_deps.bzl%go_repositories",
            "-prune",
        ],
        command = "update-repos",
    )

def merge_nogo_macro(name, nogo_config, visibility=None, exclude=None):
    """Macro for nogo configuration."""
    native.genrule(
        name=name+"_config",
        srcs= ["@rules_mgit//internal/nogo:nogo.json", nogo_config],
        tools=["@rules_mgit//internal/nogo/nogomerge:nogo_merge"],
        outs=["nogo.json"],
        cmd = "./$(location @rules_mgit//internal/nogo/nogomerge:nogo_merge) --rules-nogo $(location @rules_mgit//internal/nogo:nogo.json) --repo-nogo $(location %s) --out-file $@" % nogo_config,
        visibility=visibility,
    )
    nogo(
        name = name,
        config = name+"_config",
        visibility = ["//visibility:public"],
        deps = nogo_deps(exclude),
    )
