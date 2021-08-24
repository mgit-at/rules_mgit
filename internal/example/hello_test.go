package main

import (
	"bytes"
	"strings"
	"testing"
)

func TestHello(t *testing.T) {
	buf := &bytes.Buffer{}
	printHello(buf)
	if want, got := "Hello rules_mgIT!\n", buf.String(); !strings.HasPrefix(got, want) {
		t.Errorf("expected prefix %q, got %q", want, got)
	}
}
