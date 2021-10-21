workspace(name = "rules_mgit")

load("@rules_mgit//:deps.bzl", "rules_mgit_dependencies")

rules_mgit_dependencies()

load("//:go_deps.bzl", "go_repositories")

go_repositories()

load("@rules_mgit//:setup.bzl", "rules_mgit_setup")

rules_mgit_setup()
