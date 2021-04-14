"""def.bzl contains public definitions for rules_mgit."""

load("@bazel_gazelle//:def.bzl", "gazelle")

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