"""deps.bzl contain a macro for declaring the repository dependencies."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

def rules_mgit_dependencies():
    """Declares external repositories required by rules_mgit."""
    _bazel_skylib()
    _rules_python()
    _rules_pkg()
    _rules_proto()
    _rules_go()
    _bazel_gazelle()
    _rules_docker()
    _cacerts()
    _tini()

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
        sha256 = "778197e26c5fbeb07ac2a2c5ae405b30f6cb7ad1f5510ea6fdac03bded96cc6f",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_python/releases/download/0.2.0/rules_python-0.2.0.tar.gz",
            "https://github.com/bazelbuild/rules_python/releases/download/0.2.0/rules_python-0.2.0.tar.gz",
        ],
    )

def _rules_pkg():
    """rules_pkg contains rules for building tar, deb and rpm archives."""
    # https://github.com/bazelbuild/rules_pkg
    _maybe(
        http_archive,
        name = "rules_pkg",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.4.0/rules_pkg-0.4.0.tar.gz",
            "https://github.com/bazelbuild/rules_pkg/releases/download/0.4.0/rules_pkg-0.4.0.tar.gz",
        ],
        sha256 = "038f1caa773a7e35b3663865ffb003169c6a71dc995e39bf4815792f385d837d",
    )

def _rules_proto():
    """rules_proto contains rules for working with Google's data serialization format."""
    # https://github.com/bazelbuild/rules_proto
    _maybe(
        http_archive,
        name = "rules_proto",
        sha256 = "602e7161d9195e50246177e7c55b2f39950a9cf7366f74ed5f22fd45750cd208",
        strip_prefix = "rules_proto-97d8af4dc474595af3900dd85cb3a29ad28cc313",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_proto/archive/97d8af4dc474595af3900dd85cb3a29ad28cc313.tar.gz",
            "https://github.com/bazelbuild/rules_proto/archive/97d8af4dc474595af3900dd85cb3a29ad28cc313.tar.gz",
        ],
    )

def _rules_go():
    """rules_go is required for the Go programming language."""
    # https://github.com/bazelbuild/rules_go
    _maybe(
        http_archive,
        name = "io_bazel_rules_go",
        sha256 = "8e968b5fcea1d2d64071872b12737bbb5514524ee5f0a4f54f5920266c261acb",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.28.0/rules_go-v0.28.0.zip",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.28.0/rules_go-v0.28.0.zip",
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

def _rules_docker():
    """rules_docker contains rules for building Docker images."""
    # https://github.com/bazelbuild/rules_docker
    _maybe(
        http_archive,
        name = "io_bazel_rules_docker",
        sha256 = "59d5b42ac315e7eadffa944e86e90c2990110a1c8075f1cd145f487e999d22b3",
        strip_prefix = "rules_docker-0.17.0",
        urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.17.0/rules_docker-v0.17.0.tar.gz"],
    )

def _cacerts():
    """CA certificates (for bundling with static binaries and Docker images)."""
    # https://curl.haxx.se/docs/caextract.html
    _maybe(
        http_file,
        name = "cacert",
        downloaded_file_path = "cacert.pem",
        sha256 = "533610ad2b004c1622a40622f86ced5e89762e1c0e4b3ae08b31b240d863e91f",
        urls = ["https://curl.se/ca/cacert-2021-04-13.pem"],
    )

def _tini():
    """A tini but valid init for containers."""
    # https://github.com/krallin/tini/releases
    _maybe(
        http_file,
        name = "tini",
        sha256 = "93dcc18adc78c65a028a84799ecf8ad40c936fdfc5f2a57b1acda5a8117fa82c",
        urls = ["https://github.com/krallin/tini/releases/download/v0.19.0/tini-amd64"],
    )
    _maybe(
        http_file,
        name = "tini-static",
        sha256 = "c5b0666b4cb676901f90dfcb37106783c5fe2077b04590973b885950611b30ee",
        urls = ["https://github.com/krallin/tini/releases/download/v0.19.0/tini-static-amd64"],
    )

def _maybe(rule, name, **kwargs):
    """Declares an external repository if it hasn't been declared already."""
    if name not in native.existing_rules():
        rule(name = name, **kwargs)
