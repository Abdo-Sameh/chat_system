package common

import (
	"github.com/joho/godotenv"
	"log"
	"net/http"
	"os"
)

// AppConfig holds the configuration values from config.json and .env files
var AppConfig Configuration


func ApiResponse(w http.ResponseWriter, response []byte, code int) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(code)
	w.Write(response)
}

// Initialize AppConfig
func initConfig() {
	err := godotenv.Load(".env")

	if err != nil {
		log.Fatalf("Error loading .env file")
	}
	AppConfig = Configuration{}
	AppConfig.Server = os.Getenv("SERVER")
	//AppConfig.Database.Host = os.Getenv("DATABASE_HOST")
	//AppConfig.Database.Name = os.Getenv("DATABASE_NAME")
	//AppConfig.Database.Username = os.Getenv("DATABASE_USERNAME")
	//AppConfig.Database.Password = os.Getenv("DATABASE_PASSWORD")
	AppConfig.Database.DSN = os.Getenv("DATABASE_USERNAME") + ":" + os.Getenv("DATABASE_PASSWORD") + "@/" +
		os.Getenv("DATABASE_NAME")
}
