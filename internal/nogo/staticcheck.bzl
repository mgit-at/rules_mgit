load("@bazel_gazelle//:deps.bzl", "go_repository")

def staticcheck_repositories():
    _maybe(
        go_repository,
        name = "co_honnef_go_tools",
        build_directives = [
            "gazelle:exclude **/testdata/**",  # keep
        ],
        build_file_generation = "on",
        importpath = "honnef.co/go/tools",
        sum = "h1:/EPr//+UMMXwMTkXvCCoaJDq8cpjMO80Ou+L4PDo2mY=",
        version = "v0.2.1",
    )
    _maybe(
        go_repository,
        name = "com_github_sluongng_staticcheck_codegen",
        build_file_generation = "on",
        importpath = "github.com/sluongng/staticcheck-codegen",
        sum = "h1:kPz8OoAsTPEUybOZ23QocbXGKgRPXL6083buIAoP/S8=",
        version = "v0.0.2",
    )

def _maybe(rule, name, **kwargs):
    """Declares an external repository if it hasn't been declared already."""
    if name not in native.existing_rules():
        rule(name = name, **kwargs)
