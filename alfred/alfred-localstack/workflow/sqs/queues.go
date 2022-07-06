package main

import (
	"encoding/json"
	"fmt"
	"os/exec"
	"strings"

	aw "github.com/deanishe/awgo"
)

var (
	query string

	// repo = "nikitavoloboev/alfred-web-searches"

	// Workflow stuff
	wf *aw.Workflow
)

func init() {
	// Create a new Workflow using default settings.
	// Critical settings are provided by Alfred via environment variables,
	// so this *will* die in flames if not run in an Alfred-like environment.
	wf = aw.New()
}

type Data struct {
	QueueUrls []string
}

// Your workflow starts here
func run() {

	prg := "awslocal"

	commandType := "sqs"
	command := "list-queues"

	cmd := exec.Command(prg, commandType, command)

	stdout, err := cmd.Output()

	if err != nil {
		fmt.Println("Error in command " + err.Error())
		return
	}

	/*
			{
		    "QueueUrls": [
		        "http://localhost:4566/000000000000/brightpattern-request_bp-service",
		        "http://localhost:4566/000000000000/brightpattern-retry-request_bp-service",
		        "http://localhost:4566/000000000000/dnc-created_bp-service",
		        "http://localhost:4566/000000000000/dnc-requested_dnc-service"
		    ]
		}
	*/
	jsonString := string(stdout)

	buffer := []byte(jsonString)

	var data Data
	mErr := json.Unmarshal(buffer, &data)

	if mErr != nil {
		fmt.Println("Error in json " + mErr.Error())
		return
	}

	//TODO instead of doing this call here, do an async call to gather this and put into a file.
	for _, n := range data.QueueUrls {
		newName := strings.Replace(n, "http://localhost:4566/000000000000/", "", -1)
		//pull all elements out of queueUrls
		wf.NewFileItem(newName)
	}

	// Send results to Alfred
	wf.SendFeedback()
}

func main() {
	// Wrap your entry point with Run() to catch and log panics and
	// show an error in Alfred instead of silently dying
	wf.Run(run)
}
