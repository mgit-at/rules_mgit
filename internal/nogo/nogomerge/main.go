package main

import (
	"encoding/json"
	"errors"
	"flag"
	"fmt"
	"io/ioutil"
	"os"
)

type Args struct {
	RulesNogo string
	RepoNogo  string
	OutFile   string
}

func main() {
	var args Args

	flag.StringVar(&args.RulesNogo, "rules-nogo", "../nogo/nogo.json", "input file from rules_mgit")
	flag.StringVar(&args.RepoNogo, "repo-nogo", "", "input file from other repository")
	flag.StringVar(&args.OutFile, "out-file", "nogo.json", "name of the file that should be written to")
	flag.Parse()

	if err := run(&args); err != nil {
		fmt.Println("error:", err)
		os.Exit(1)
	}

}

func run(args *Args) error {
	if err := checkArgs(args); err != nil {
		return fmt.Errorf("checkArgs %w", err)
	}

	repo, rules, err := createMaps(args)
	if err != nil {
		return fmt.Errorf("createMaps: %w", err)
	}

	merged, err := mergeMaps(repo, rules)
	if err != nil {
		return fmt.Errorf("mergeMaps %w", err)
	}

	jsonStr, err := json.Marshal(merged)
	if err != nil {
		return fmt.Errorf("json.Marshal %w", err)
	}

	outFile, err := os.OpenFile(args.OutFile, os.O_CREATE, os.ModePerm)
	if err != nil {
		return fmt.Errorf("os.OpenFile %w", err)
	}
	defer outFile.Close()

	if err := ioutil.WriteFile(args.OutFile, jsonStr, os.ModePerm); err != nil {
		return fmt.Errorf("ioutil.WriteFile %w", err)
	}

	return nil
}

func checkArgs(args *Args) error {
	files := []string{args.RepoNogo, args.RulesNogo}
	for _, file := range files {
		if _, err := os.Stat(file); errors.Is(err, os.ErrNotExist) {
			return fmt.Errorf("os.Stat %q %w", file, err)
		}
	}
	return nil
}

func createMaps(args *Args) (map[string]interface{}, map[string]interface{}, error) {
	bytes, err := readFile(args.RepoNogo)
	if err != nil {
		return nil, nil, fmt.Errorf("readFile: %w", err)
	}

	var repo map[string]interface{}
	if err := json.Unmarshal(bytes, &repo); err != nil {
		return nil, nil, fmt.Errorf("json.Unmarshal %w", err)
	}

	if err := checkRepoMap(repo); err != nil {
		return nil, nil, fmt.Errorf("checkRepoMap: %w", err)
	}

	bytes, err = readFile(args.RulesNogo)
	if err != nil {
		return nil, nil, fmt.Errorf("readFile: %w", err)
	}
	var rules map[string]interface{}
	if err := json.Unmarshal(bytes, &rules); err != nil {
		return nil, nil, fmt.Errorf("json.Unmarshal %w", err)
	}

	return repo, rules, nil
}

func readFile(file string) ([]byte, error) {
	f, err := os.Open(file)
	if err != nil {
		return nil, fmt.Errorf("os.Open %w", err)
	}
	defer f.Close()

	bytes, err := ioutil.ReadAll(f)
	if err != nil {
		return nil, fmt.Errorf("ioutil.ReadAll %w", err)
	}
	return bytes, nil
}

func checkRepoMap(repo map[string]interface{}) error {
	validKeys := true
	if _, ok := repo["add"]; !ok {
		validKeys = false
	}
	if _, ok := repo["delete"]; !ok {
		validKeys = false
	}

	if !validKeys {
		return errors.New("map contains incorrect keys, it can only contain add and/or delete")
	}

	return nil
}

func mergeMaps(repo map[string]interface{}, rules map[string]interface{}) (map[string]interface{}, error) {
	toAdd, ok := repo["add"].([]interface{})
	if !ok {
		return nil, fmt.Errorf("entries in map on key add has wrong type")
	}
	toDelete, ok := repo["delete"].([]interface{})
	if !ok {
		return nil, fmt.Errorf("entries in map on key delete has wrong type")
	}

	for _, k := range toDelete {
		if _, ok := k.(string); !ok {
			return nil, fmt.Errorf("entry in map on key delete has wrong type")
		}
		delete(rules, k.(string))
	}

	for _, m := range toAdd {
		if _, ok := m.(map[string]interface{}); !ok {
			return nil, fmt.Errorf("entry in map on key add has wrong type")
		}
		// Should always be one key value pair only
		for k, v := range m.(map[string]interface{}) {
			rules[k] = v
		}
	}

	return rules, nil
}
