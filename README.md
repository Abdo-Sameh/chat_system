# Chat System Application
## Overview
A simple Chat System.

## Requirements
- Docker
- Docker-compose

## How to run
1. Clone repository

* `git clone https://github.com/Abdo-Sameh/chat_system.git`

2. run app

* `cd chat_system`
* `sudo docker-compose up --build -d`

## APIs
### Application routes
Method | Path                         | Params | Description |
-------|------------------------------|--------| ----------- |
GET    | /api/v1/applications/        |        | List all applications |
GET    | /api/v1/applications/:token  | `token`| Get specific application using it's token |
POST   | /api/v1/applications         | `name` **sent in the request body**| Create new Application |
PUT    | /api/v1/applications/:token  | `token`, `name` **sent in the request body**  | Update Specific application|

### Chat routes
Method | Path                         | Params | Description |
-------|------------------------------|--------| ----------- |
GET    | /api/v1/applications/:application_token/chats| | List all chats for specific application |
GET    | /api/v1/applications/:application_token/chats/:number| `application_token`, `number`| Get specific application chat using it's number |
POST   | /api/v1/applications/:application_token/chats      | `application_token` | Create new chat for specific application |
PUT    | /api/v1/applications/:application_token/chats/:number  | `application_token`, `number` | Update Specific application chat |
GET    | /api/v1/applications/:application_token/chats/:number/search | `application_token`, `number`, `q` **send in request body** | Search for message body among all chat messages |

### Message routes
Method | Path                         | Params | Description |
-------|------------------------------|--------| ----------- |
GET    | /api/v1/applications/:application_token/chats/:chat_number/messages/:number| `application_token`, `chat_number`, `number` | Get specific message |
GET    | /api/v1/applications/:application_token/chats/:chat_number/messages| `application_token`, `chat_number` | List all messages for specific chat |
POST   | /api/v1/applications/:application_token/chats/:chat_number/messages | `application_token`, `chat_number` | Create new message for specific chat |
PUT    | /api/v1/applications/:application_token/chats/:chat_number/messages/:number  | `application_token`, `number`, `body` **sent in the request body** | Update message for specific chat |
