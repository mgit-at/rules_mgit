load("@io_bazel_rules_go//go:def.bzl", "TOOLS_NOGO")
load("@com_github_sluongng_staticcheck_codegen//:def.bzl", "SENSIBLE_ANALYZERS")
load("@bazel_skylib//lib:new_sets.bzl", "sets")

def nogo_deps():
    deps = sets.union(sets.make(TOOLS_NOGO), sets.make(SENSIBLE_ANALYZERS))
    sets.insert(deps, "//internal/nogo/nogofmt")
    sets.remove(deps, "@org_golang_x_tools//go/analysis/passes/shadow:go_default_library")
    sets.remove(deps, "@org_golang_x_tools//go/analysis/passes/pkgfact:go_default_library")
    sets.remove(deps, "@com_github_sluongng_staticcheck_codegen//_gen/st1000:go_default_library")
    # print(sets.str(deps))
    return sets.to_list(deps)
