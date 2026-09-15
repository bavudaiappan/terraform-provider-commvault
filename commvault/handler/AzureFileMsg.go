package handler

// MsgCreateAzureFileInstanceRequest represents POST /V4/azurefile/instance.
type MsgCreateAzureFileInstanceRequest struct {
	Name        *string                  `json:"name,omitempty"`
	Credential  *MsgIdName               `json:"credential,omitempty"`
	Plan        *MsgIdName               `json:"plan,omitempty"`
	Contents    *MsgAzureFileContents    `json:"contents,omitempty"`
	HostURL     *string                  `json:"hostURL,omitempty"`
	Region      *MsgIdName               `json:"region,omitempty"`
	AccessNodes []MsgAzureFileAccessNode `json:"accessNodes,omitempty"`
}

type MsgAzureFileContents struct {
	Path       []string `json:"path,omitempty"`
	Exclusions []string `json:"exclusions,omitempty"`
	Exceptions []string `json:"exceptions,omitempty"`
}

type MsgAzureFileAccessNode struct {
	Id   *int    `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
	Type *string `json:"type,omitempty"`
}

type MsgCreateAzureFileInstanceResponse struct {
	Id           *int    `json:"id,omitempty"`
	Name         *string `json:"name,omitempty"`
	ErrorCode    *int    `json:"errorCode,omitempty"`
	FailedStage  *string `json:"failedStage,omitempty"`
	ErrorMessage *string `json:"errorMessage,omitempty"`
}
