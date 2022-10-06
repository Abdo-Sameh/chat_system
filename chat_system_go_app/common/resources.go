package common

type (

	Configuration struct {
		Server     string   `json:"Server"`
		Database   Database `json:"Database"`
	}

	Database struct {
		//Host     string `json:"host"`
		//Username string `json:"username"`
		//Password string `json:"password"`
		//Name     string `json:"name"`
		DSN 	 string	`json:"dsn"`
	}

)