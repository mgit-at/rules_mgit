rules_mgit
==========

A set of Bazel rules to build common mgIT projects.

This repository depends on various other Bazel repositories like ``rules_go``, ``rules_proto`` and ``rules_pkg``,
which  are typically needed for projects by mgIT. Rarely used dependencies (e.g. Scala) are outside the scope of
this repository and should be used directly. All dependencies have been tested to work well together and are
updated regularly.

The configuration of the repositories is rather opinionated. For example, various linter rules and gofmt
checks are enforced. This repository also contains common rules for working with Gazelle and comes with an
opinionated Gazelle config as well.

Setup
-----

Create a ``WORKSPACE`` file at the top of your repository and add the snipped below. Please use the
latest ``GIT_COMMIT`` and the correct ``SHA256_SUM``.

```
workspace(name = "my_project")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
    name = "rules_mgit",
    url = "https://github.com/mgit-at/rules_mgit/archive/GIT_COMMIT.zip",
    sha256 = "SHA256_SUM",
    strip_prefix = "rules_mgit-GIT_COMMIT",
    type = "zip",
)

load("@rules_mgit//:deps.bzl", "rules_mgit_dependencies")
rules_mgit_dependencies()

load("@rules_mgit//:setup.bzl", "rules_mgit_setup")
rules_mgit_setup()

load("//:go_deps.bzl", "go_repositories")
go_repositories()
```

The ``go_deps.bzl`` is updated by Gazelle and might look like this at the beginning:

```
def go_repositories():
    pass
```

The top-level ``BUILD.bazel`` file should contain the following snippet:

```
load("@rules_mgit//:def.bzl", "mgit_repo_rules")

mgit_repo_rules(
    go_prefix = "mgit.at/prometheus-mgit-exporter",
)
```

Usage
-----

Whenever a new dependency has been added to the ``go.mod`` file, run the following command in order to update
the ``go_deps.bzl`` file appropriately:

```
bazel run //:gazelle-update-repos
```

After adding a new Go file or import statement, run the following command. It will automatically generate
and update ``BUILD.bazel`` files for the whole project:

```
bazel run //:gazelle
```
