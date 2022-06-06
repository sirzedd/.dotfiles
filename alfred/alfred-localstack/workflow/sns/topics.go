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
	Topics []struct {
		TopicArn string
	}
}

// Your workflow starts here
func run() {

	prg := "awslocal"

	commandType := "sns"
	command := "list-topics"

	cmd := exec.Command(prg, commandType, command)

	stdout, err := cmd.Output()

	if err != nil {
		fmt.Println("Error in command " + err.Error())
		return
	}

	/*
				{
		    "Topics": [
		        {
		            "TopicArn": "arn:aws:sns:us-west-2:000000000000:brightpattern-request"
		        },
		        {
		            "TopicArn": "arn:aws:sns:us-west-2:000000000000:brightpattern-retry-request"
		        },
		        {
		            "TopicArn": "arn:aws:sns:us-west-2:000000000000:dnc-created"
		        },
		        {
		            "TopicArn": "arn:aws:sns:us-west-2:000000000000:dnc-requested"
		        }
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
	for _, n := range data.Topics {
		topicArn := n.TopicArn
		newName := strings.Replace(topicArn, "arn:aws:sns:us-west-2:000000000000:", "", -1)
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
