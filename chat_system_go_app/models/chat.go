package models

import (
	"apps/gateway/dbGateway"
	"time"
)


type Chat struct {

	ID 				uint8		`db:"id" bson:"id"`
	ChatNumber		uint8		`db:"chat_number" bson:"chat_number"`
	ApplicationID	uint8		`db:"application_id" bson:"application_id"`
	MessagesCount	uint8		`db:"messages_count" bson:"messages_count"`
	CreatedAt 		time.Time 	`db:"created_at" bson:"created_at"`
	UpdatedAt 		time.Time 	`db:"updated_at" bson:"updated_at"`
}

func (chat *Chat) Create() error {
	err := dbGateway.Create(DbCollectionName, app)
	return err
}
