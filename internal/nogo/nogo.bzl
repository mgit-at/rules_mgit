load("@io_bazel_rules_go//go:def.bzl", "TOOLS_NOGO")

def nogo_deps():
    deps = list(TOOLS_NOGO)
    deps.append("//internal/nogo/nogofmt")
    deps.remove("@org_golang_x_tools//go/analysis/passes/shadow:go_default_library")
    deps.remove("@org_golang_x_tools//go/analysis/passes/pkgfact:go_default_library")
    return deps
