package main

import (
	"bytes"
	"strings"
	"testing"

	"mgit.at/rules_go/internal/example/lib"
)

func TestHello(t *testing.T) {
	buf := &bytes.Buffer{}
	lib.PrintHello(buf)
	if want, got := "Hello rules_mgIT!\n", buf.String(); !strings.HasPrefix(got, want) {
		t.Errorf("expected prefix %q, got %q", want, got)
	}
}
