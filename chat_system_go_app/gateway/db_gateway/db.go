package db_gateway

import (
	"chat_system/common"
	"database/sql"
)


func OpenDatabaseConnection() (*sql.DB, error) {
	db, err := sql.Open("mysql", common.AppConfig.Database.DSN)
	if err != nil {
		return nil, err
	}
	return db, nil
}
