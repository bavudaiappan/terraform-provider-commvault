package handler

import (
	"encoding/json"
	"net/http"
	"os"
)

// CvCreateAzureFileInstance creates an Azure File Share instance.
func CvCreateAzureFileInstance(req MsgCreateAzureFileInstanceRequest) (*MsgCreateAzureFileInstanceResponse, error) {
	reqBody, _ := json.Marshal(req)
	url := os.Getenv("CV_CSIP") + "/V4/azurefile/instance"
	token := os.Getenv("AuthToken")
	respBody, err := makeHttpRequestErr(url, http.MethodPost, JSON, reqBody, JSON, token, 0)
	var respObj MsgCreateAzureFileInstanceResponse
	json.Unmarshal(respBody, &respObj)
	return &respObj, err
}
