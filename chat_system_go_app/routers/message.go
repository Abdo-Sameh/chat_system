package routers

import (
	"github.com/gorilla/mux"
	"net/http"
	"chat_system/controllers"
)

func SetMessageRouters(router *mux.Router) *mux.Router {
	router.Handle("/applications/:application_token/chats", http.HandlerFunc(controllers.CreateMessage)).Methods("POST")
	return router
}
