package main

import (
	"fmt"
	"io"
	"os"
	"runtime"
)

func main() {
	printHello(os.Stdout)
}

func printHello(w io.Writer) {
	fmt.Fprintln(w, "Hello rules_mgIT!")
	fmt.Fprintln(w, "go_version:", runtime.Version())
}
