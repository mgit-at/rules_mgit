load("@bazel_gazelle//:deps.bzl", "go_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def staticcheck_repositories():
    _maybe(
        go_repository,
        name = "org_golang_x_exp_typeparams",
        importpath = "golang.org/x/exp/typeparams",
        sum = "h1:WumQqbro49zP5y7xSPDDdBZBwiUrWNZ7ZbKUQst9RiA=",
        version = "v0.0.0-20221217163422-3c43f8badb15",
    )
    _maybe(
        go_repository,
        name = "com_github_burntsushi_toml",
        importpath = "github.com/BurntSushi/toml",
        sum = "h1:9F2/+DoOYIOksmaJFPw1tGFy1eDnIJXg+UHjuD8lTak=",
        version = "v1.2.1",
    )
    _maybe(
        go_repository,
        name = "co_honnef_go_tools",
        build_directives = [
            "gazelle:exclude **/testdata/**",  # keep
        ],
        build_file_generation = "on",
        importpath = "honnef.co/go/tools",
        sum = "h1:oDx7VAwstgpYpb3wv0oxiZlxY+foCpRAwY7Vk6XpAgA=",
        version = "v0.3.3",
        build_external = "external",
    )
    _maybe(
        http_archive,
        name = "com_github_sluongng_nogo_analyzer",
        sha256 = "ab9ab7936b6d490ff92bb8e3e03bc3ace3406f0b4d1625cc0720d0e9e81a369a",
        strip_prefix = "nogo-analyzer-0.0.1",
        urls = [
            "https://github.com/sluongng/nogo-analyzer/archive/refs/tags/v0.0.1.tar.gz",
        ],
    )

def _maybe(rule, name, **kwargs):
    """Declares an external repository if it hasn't been declared already."""
    if name not in native.existing_rules():
        rule(name = name, **kwargs)
