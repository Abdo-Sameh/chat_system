package controllers

import (
	"chat_system/data"
	gateway "chat_system/gateway/db_gateway"
	"encoding/json"
	"log"
	"net/http"
)

func CreateMessage(w http.ResponseWriter, req *http.Request) {
	var messageResource data.MessageResource

	err := json.NewDecoder(req.Body).Decode(&messageResource)
	if err != nil {
		//common.DisplayAppError(w, err, common.ErrorMessages.InvalidResourceData, http.StatusBadRequest)
		return
	}
	db, err := gateway.OpenDatabaseConnection()
	if err != nil {
		log.Fatal(err)
	}

	_ = db.Close()
}