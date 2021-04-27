package main

import (
	"bytes"
	"testing"
)

func TestHello(t *testing.T) {
	buf := &bytes.Buffer{}
	printHello(buf)
	if want, got := "Hello rules_mgIT!\n", buf.String(); want != got {
		t.Errorf("expected %q, got %q", want, got)
	}
}
