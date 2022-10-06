package main

import (
	"chat_system/common"
	"chat_system/routers"
	"log"
	"net/http"
	"time"
)

func main() {

	// Calls startup logic
	common.StartUp()
	// Get the mux router object
	router := routers.InitRoutes()

	server := &http.Server{
		Addr:         common.AppConfig.Server,
		Handler:      router,
		ReadTimeout:  60 * time.Second,
		WriteTimeout: 60 * time.Second,
	}
	log.Println("Chat System: Listening...")
	_ = server.ListenAndServe()
}
