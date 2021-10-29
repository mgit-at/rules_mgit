// Package unused reports unused code.
package unused

import (
	"golang.org/x/tools/go/analysis"
	"honnef.co/go/tools/unused"
)

var Analyzer = &analysis.Analyzer{
	Name:     "unused",
	Doc:      "unused code",
	Run:      run,
	Requires: []*analysis.Analyzer{unused.Analyzer.Analyzer},
}

func run(pass *analysis.Pass) (interface{}, error) {
	unused := pass.ResultOf[unused.Analyzer.Analyzer].(unused.Result)
	for _, u := range unused.Unused {
		pass.Reportf(u.Pos(), "unused code: %s", u)
	}
	return nil, nil
}
