package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"regexp"
	"runtime"
	"sort"
	"strings"

	"github.com/ktr0731/go-fuzzyfinder"
	"github.com/pkg/browser"
	"github.com/spf13/cobra"
)

var workingDir string

func main() {
	rootCmd := &cobra.Command{
		Use:   "fzf-url-selector",
		Short: "A script to select URLs from descriptions using FZF",
		Run:   run,
	}

	homeDir, err := os.UserHomeDir()
	if err != nil {
		fmt.Printf("Error fetching home directory: %v\n", err)
		return
	}

	workingDir = fmt.Sprintf("%s/%s", homeDir, "files/docs/lnks-bookmarks")

	fmt.Println("Working dir", workingDir)

	// Define flags
	rootCmd.Flags().StringVarP(&workingDir, "directory", "d", workingDir, "Set the working directory containing .txt files")

	if err := rootCmd.Execute(); err != nil {
		fmt.Printf("Error executing command: %v\n", err)
		os.Exit(1)
	}
}

func run(cmd *cobra.Command, args []string) {
	absWorkingDir, err := filepath.Abs(workingDir)
	if err != nil {
		fmt.Printf("Error resolving absolute path: %v\n", err)
		return
	}
	fmt.Printf("Using working directory: %s\n", absWorkingDir)

	var entries []string
	var descriptions []string

	err = filepath.Walk(absWorkingDir, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}
		if !info.IsDir() && strings.HasSuffix(path, ".txt") {
			file, err := os.Open(path)
			if err != nil {
				return err
			}
			defer file.Close()
			scanner := bufio.NewScanner(file)
			for scanner.Scan() {
				line := strings.TrimSpace(scanner.Text())
				if line != "" {
					description := extractDescription(line)
					entries = append(entries, line)
					descriptions = append(descriptions, description)
				}
			}
		}
		return nil
	})
	if err != nil {
		fmt.Printf("Error reading files: %v\n", err)
		return
	}

	sort.SliceStable(descriptions, func(i, j int) bool {
		return descriptions[i] < descriptions[j]
	})

	sortedEntries := make([]string, len(entries))
	for i, description := range descriptions {
		for _, entry := range entries {
			if extractDescription(entry) == description {
				sortedEntries[i] = entry
				break
			}
		}
	}

	index, err := fuzzyfinder.Find(sortedEntries, func(i int) string {
		return extractDescription(sortedEntries[i])
	})
	if err != nil {
		fmt.Println("Selection cancelled.")
		return
	}

	selectedEntry := sortedEntries[index]
	description := extractDescription(selectedEntry)
	url := extractURL(selectedEntry)

	fmt.Printf("You selected: %s\n", description)

	url, err = handleParams(url, absWorkingDir)
	if err != nil {
		fmt.Printf("Error handling params: %v\n", err)
		return
	}

	fmt.Printf("Opening URL: %s\n", url)
	//	fmt.Println("Path", os.Getenv("PATH"))
	err = browser.OpenURL(url)
	//err = openURL(url)
	if err != nil {
		fmt.Printf("Error opening URL: %v\n", err)
	}
}

func extractDescription(line string) string {
	lastSpaceIndex := strings.LastIndex(line, " ")
	if lastSpaceIndex == -1 {
		return line
	}
	return line[:lastSpaceIndex]
}

func extractURL(line string) string {
	lastSpaceIndex := strings.LastIndex(line, " ")
	if lastSpaceIndex == -1 {
		return ""
	}
	return line[lastSpaceIndex+1:]
}

func handleParams(url string, absWorkingDir string) (string, error) {
	re := regexp.MustCompile(`\$\{([^}]+)\}`)
	matches := re.FindAllStringSubmatch(url, -1)

	for _, match := range matches {
		param := match[1]
		if strings.Contains(param, "|") {
			choices := strings.Split(param, "|")
			index, err := fuzzyfinder.Find(choices, func(i int) string { return choices[i] })
			if err != nil {
				return "", err
			}
			url = strings.Replace(url, match[0], choices[index], 1)
		} else if strings.HasSuffix(param, ".sh") {
			scriptPath := filepath.Join(absWorkingDir, "files", param)
			output, err := exec.Command(scriptPath).Output()
			if err != nil {
				return "", fmt.Errorf("failed to execute script %s: %v", scriptPath, err)
			}
			options := strings.Split(strings.TrimSpace(string(output)), "\n")
			index, err := fuzzyfinder.Find(options, func(i int) string { return options[i] })
			if err != nil {
				return "", err
			}
			url = strings.Replace(url, match[0], options[index], 1)
		} else {
			reader := bufio.NewReader(os.Stdin)
			fmt.Printf("Enter value for %s: ", param)
			input, err := reader.ReadString('\n')
			if err != nil {
				return "", err
			}
			url = strings.Replace(url, match[0], strings.TrimSpace(input), 1)
		}
	}
	return url, nil
}

// Function to open the URL explicitly
func openURL(url string) error {
	var cmd *exec.Cmd
	switch runtime.GOOS {
	case "linux":
		fmt.Println("xdg-open", url)
		cmd = exec.Command("xdg-open", url)
	case "darwin":
		fmt.Println("open", "-u", url)
		//Need to add -u since mac doesn't recognize some of the url formats and won't open
		cmd = exec.Command("open", "-u", url)
	case "windows":
		fmt.Println("rundll32", "url.dll,FileProtocolHandler", url)
		cmd = exec.Command("rundll32", "url.dll,FileProtocolHandler", url)
	default:
		return fmt.Errorf("unsupported platform")
	}
	return cmd.Start()
}
