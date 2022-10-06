package controllers

import (
	"chat_system/data"
	gateway "chat_system/gateway/db_gateway"
	"encoding/json"
	"log"
	"net/http"
)

func CreateChat(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {
	var chatResource data.ChatResource

	err := json.NewDecoder(r.Body).Decode(&chatResource)
	if err != nil {
		//common.DisplayAppError(w, err, common.ErrorMessages.InvalidResourceData, http.StatusBadRequest)
		return
	}
	db, err := gateway.OpenDatabaseConnection()
	if err != nil {
		log.Fatal(err)
	}

	defer db.Close()
}