package main

import (
	"encoding/json"
	"io"
	"net/http"
	"os"
)

type SyncInfo struct {
	CatchingUp bool `json:"catching_up"`
}

type Result struct {
	SyncInfo SyncInfo `json:"sync_info"`
}

type StatusResponse struct {
	Result Result `json:"result"`
}

func main() {
	resp, err := http.Get("http://localhost:26657/status")
	if err != nil {
		os.Exit(10)
		return
	}

	defer func(Body io.ReadCloser) {
		_ = Body.Close()
	}(resp.Body)

	var statusResponse StatusResponse
	err = json.NewDecoder(resp.Body).Decode(&statusResponse)
	if err != nil {
		os.Exit(20)
		return
	}

	if statusResponse.Result.SyncInfo.CatchingUp {
		os.Exit(30)
	}

	os.Exit(0)
}
