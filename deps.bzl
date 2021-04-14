"""deps.bzl contain a macro for declaring the repository dependencies."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def rules_mgit_dependencies():
    """Declares external repositories required by rules_mgit."""
    _bazel_skylib()
    _rules_python()
    _rules_pkg()
    _rules_proto()
    _rules_go()
    _bazel_gazelle()

def _bazel_skylib():
    """bazel_skylib is a set of libraries thar are useful for writing Bazel rules."""
    # https://github.com/bazelbuild/bazel-skylib
    _maybe(
        http_archive,
        name = "bazel_skylib",
        sha256 = "1c531376ac7e5a180e0237938a2536de0c54d93f5c278634818e0efc952dd56c",
        urls = [
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.0.3/bazel-skylib-1.0.3.tar.gz",
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.0.3/bazel-skylib-1.0.3.tar.gz",
        ],
    )

def _rules_python():
    """rules_python is required for Python."""
    # https://github.com/bazelbuild/rules_python
    _maybe(
        http_archive,
        name = "rules_python",
        sha256 = "b6d46438523a3ec0f3cead544190ee13223a52f6a6765a29eae7b7cc24cc83a0",
        url = "https://github.com/bazelbuild/rules_python/releases/download/0.1.0/rules_python-0.1.0.tar.gz",
    )

def _rules_pkg():
    """rules_pkg contains rules for building tar, deb and rpm archives."""
    # https://github.com/bazelbuild/rules_pkg
    _maybe(
        http_archive,
        name = "rules_pkg",
        sha256 = "6b5969a7acd7b60c02f816773b06fcf32fbe8ba0c7919ccdc2df4f8fb923804a",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.3.0/rules_pkg-0.3.0.tar.gz",
            "https://github.com/bazelbuild/rules_pkg/releases/download/0.3.0/rules_pkg-0.3.0.tar.gz",
        ],
    )

def _rules_proto():
    """rules_proto contains rules for working with Google's data serialization format."""
    # https://github.com/bazelbuild/rules_proto
    _maybe(
        http_archive,
        name = "rules_proto",
        sha256 = "9fc210a34f0f9e7cc31598d109b5d069ef44911a82f507d5a88716db171615a8",
        strip_prefix = "rules_proto-f7a30f6f80006b591fa7c437fe5a951eb10bcbcf",
        urls = [
            "https://github.com/bazelbuild/rules_proto/archive/f7a30f6f80006b591fa7c437fe5a951eb10bcbcf.tar.gz",
        ],
    )

def _rules_go():
    """rules_go is required for the Go programming language."""
    # https://github.com/bazelbuild/rules_go
    _maybe(
        http_archive,
        name = "io_bazel_rules_go",
        sha256 = "7c10271940c6bce577d51a075ae77728964db285dac0a46614a7934dc34303e6",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.26.0/rules_go-v0.26.0.tar.gz",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.26.0/rules_go-v0.26.0.tar.gz",
        ],
    )

def _bazel_gazelle():
    """bazel_gazelle is a Bazel build file generate for Go."""
    # https://github.com/bazelbuild/bazel-gazelle
    _maybe(
        http_archive,
        name = "bazel_gazelle",
        sha256 = "62ca106be173579c0a167deb23358fdfe71ffa1e4cfdddf5582af26520f1c66f",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.23.0/bazel-gazelle-v0.23.0.tar.gz",
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.23.0/bazel-gazelle-v0.23.0.tar.gz",
        ],
    )

def _maybe(rule, name, **kwargs):
    """Declares an external repository if it hasn't been declared already."""
    if name not in native.existing_rules():
        rule(name = name, **kwargs)
