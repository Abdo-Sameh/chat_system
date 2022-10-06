package routers

import (
	"github.com/gorilla/mux"
)

func InitRoutes() *mux.Router {
	router := mux.NewRouter().StrictSlash(false)
	// Routes for the App entity
	router = SetChatRouters(router)
	router = SetMessageRouters(router)

	return router
}