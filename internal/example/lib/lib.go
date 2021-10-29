package lib

import (
	"fmt"
	"io"
	"runtime"
)

func PrintHello(w io.Writer) {
	fmt.Fprintln(w, "Hello rules_mgIT!")
	fmt.Fprintln(w, "go_version:", runtime.Version())
}
