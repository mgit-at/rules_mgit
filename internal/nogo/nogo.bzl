load("@io_bazel_rules_go//go:def.bzl", "TOOLS_NOGO")
load("@com_github_sluongng_nogo_analyzer//staticcheck:def.bzl", "staticcheck_analyzers", "ANALYZERS")
load("@bazel_skylib//lib:new_sets.bzl", "sets")

def nogo_deps(exclude=None):
    deps = sets.make(TOOLS_NOGO + staticcheck_analyzers(ANALYZERS))
    sets.insert(deps, "@rules_mgit//internal/nogo/nogofmt")
    sets.insert(deps, "@rules_mgit//internal/nogo/unused")
    sets.remove(deps, "@org_golang_x_tools//go/analysis/passes/shadow:go_default_library")
    sets.remove(deps, "@org_golang_x_tools//go/analysis/passes/pkgfact:go_default_library")
    if exclude != None:
        for e in exclude:
            sets.remove(deps, e)
    # print(sets.str(deps))
    return sets.to_list(deps)
