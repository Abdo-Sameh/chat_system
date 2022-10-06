package routers

import (
	"chat_system/controllers"
	"github.com/gorilla/mux"
	"net/http"
)

func SetChatRouters(router *mux.Router) *mux.Router {
	router.Handle("/applications/:application_token/chats", http.HandlerFunc(controllers.CreateChat)).Methods("POST")
	return router
}
