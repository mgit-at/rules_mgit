"""deps.bzl contain a macro for declaring the repository dependencies."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

def rules_mgit_dependencies():
    """Declares external repositories required by rules_mgit."""
    _bazel_skylib()
    _rules_python()
    _rules_pkg()
    _rules_protobuf()
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
        sha256 = "c6966ec828da198c5d9adbaa94c05e3a1c7f21bd012a0b29ba8ddbccb2c93b0d",
        urls = [
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
        ],
    )

def _rules_python():
    """rules_python is required for Python."""
    # https://github.com/bazelbuild/rules_python
    _maybe(
        http_archive,
        name = "rules_python",
        sha256 = "954aa89b491be4a083304a2cb838019c8b8c3720a7abb9c4cb81ac7a24230cea",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_python/releases/download/0.4.0/rules_python-0.4.0.tar.gz",
            "https://github.com/bazelbuild/rules_python/releases/download/0.4.0/rules_python-0.4.0.tar.gz",
        ],
    )

def _rules_pkg():
    """rules_pkg contains rules for building tar, deb and rpm archives."""
    # https://github.com/bazelbuild/rules_pkg
    _maybe(
        http_archive,
        name = "rules_pkg",
        sha256 = "a89e203d3cf264e564fcb96b6e06dd70bc0557356eb48400ce4b5d97c2c3720d",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.5.1/rules_pkg-0.5.1.tar.gz",
            "https://github.com/bazelbuild/rules_pkg/releases/download/0.5.1/rules_pkg-0.5.1.tar.gz",
        ],
    )

def _rules_protobuf():
    """rules_protobuf contains rules for compiling Protocol Buffer specifications"""
    # https://github.com/protocolbuffers/protobuf
    _maybe(
        http_archive,
        name = "com_google_protobuf",
        sha256 = "9111bf0b542b631165fadbd80aa60e7fb25b25311c532139ed2089d76ddf6dd7",
        strip_prefix = "protobuf-3.18.1",
        urls = [
            #"https://mirror.bazel.build/github.com/protocolbuffers/protobuf/archive/v3.18.1.tar.gz",
            "https://github.com/protocolbuffers/protobuf/archive/v3.18.1.tar.gz",
        ],
    )

def _rules_go():
    """rules_go is required for the Go programming language."""
    # https://github.com/bazelbuild/rules_go
    _maybe(
        http_archive,
        name = "io_bazel_rules_go",
        sha256 = "2b1641428dff9018f9e85c0384f03ec6c10660d935b750e3fa1492a281a53b0f",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.29.0/rules_go-v0.29.0.zip",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.29.0/rules_go-v0.29.0.zip",
        ],
    )

def _bazel_gazelle():
    """bazel_gazelle is a Bazel build file generate for Go."""
    # https://github.com/bazelbuild/bazel-gazelle
    _maybe(
        http_archive,
        name = "bazel_gazelle",
        sha256 = "de69a09dc70417580aabf20a28619bb3ef60d038470c7cf8442fafcf627c21cb",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.24.0/bazel-gazelle-v0.24.0.tar.gz",
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.24.0/bazel-gazelle-v0.24.0.tar.gz",
        ],
    )

def _rules_docker():
    """rules_docker contains rules for building Docker images."""
    # https://github.com/bazelbuild/rules_docker
    _maybe(
        http_archive,
        name = "io_bazel_rules_docker",
        sha256 = "1f4e59843b61981a96835dc4ac377ad4da9f8c334ebe5e0bb3f58f80c09735f4",
        strip_prefix = "rules_docker-0.19.0",
        urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.19.0/rules_docker-v0.19.0.tar.gz"],
    )

def _cacerts():
    """CA certificates (for bundling with static binaries and Docker images)."""
    # https://curl.haxx.se/docs/caextract.html
    _maybe(
        http_file,
        name = "cacert",
        downloaded_file_path = "cacert.pem",
        sha256 = "f524fc21859b776e18df01a87880efa198112214e13494275dbcbd9bcb71d976",
        urls = ["https://curl.se/ca/cacert-2021-09-30.pem"],
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
