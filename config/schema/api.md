## <a name="resource-user"></a>User

The User resource for the API

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **city** | *string* | city of user | `"Annapolis"` |
| **country** | *string* | country of user | `"USA"` |
| **created_at** | *date-time* | when user was created | `"2015-01-01T12:00:00Z"` |
| **first_name** | *string* | first name of user | `"Nate"` |
| **id** | *integer* | unique identifier of user | `"1294"` |
| **last_name** | *string* | last name of user | `"Pauzenga"` |
| **state** | *string* | state of user | `"Maryland"` |
| **updated_at** | *date-time* | when user was updated | `"2015-01-01T12:00:00Z"` |

### User Create

Create a new user.

```
POST /users
```

#### Required Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **city** | *string* | city of user | `"Annapolis"` |
| **country** | *string* | country of user | `"USA"` |
| **email** | *string* | unique email of user | `"test@admin.com"` |
| **first_name** | *string* | first name of user | `"Nate"` |
| **last_name** | *string* | last name of user | `"Pauzenga"` |
| **password** | *string* | password of user | `"helloworld"` |
| **state** | *string* | state of user | `"Maryland"` |



#### Curl Example

```bash
$ curl -n -X POST http://localhost:3000/users \
  -d '{
  "first_name": "Nate",
  "last_name": "Pauzenga",
  "email": "test@admin.com",
  "city": "Annapolis",
  "state": "Maryland",
  "country": "USA",
  "password": "helloworld"
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
{
  "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzUxMiJ9.eyJkYXRhIjp7ImlkIjoiMTE0MzYiLCJ0eXBlIjoiYWNjb3VudHMiLCJhdHRyaWJ1dGVzIjp7ImVtYWlsIjoiZ2xlbm4uZ29vZHJpY2hAZ21haWwuY29tIn19LCJzdWIiOiJhY2NvdW50IiwiZXhwIjoxNDM3MjM0OTM0LCJpc3MiOiJVbmlxdWUgVVNBIiwiaWF0IjoxNDM3MTQ4NTM0LCJqdGkiOiI3ZmJiYTgzOS1kMGRiLTQwODItOTBmZC1kNmMwM2YwN2NmMWMifQ.SuAAhWPz_7VfJ2iyQpPEHjAnj_aZ-0-gI4uptFucWWflQnrYJl3Z17vAjypiQB_6io85Nuw7VK0Kz2_VHc7VHZwAjxMpzSvigzpUS4HHjSsDil8iYocVEFlnJWERooCOCjSB9R150Pje1DKB8fNeePUGbkCDH6QSk2BsBzT07yT-7zrTJ7kRlsJ-3Kw2GDnvSbb_k2ecX_rkeMeaMj3FmF3PDBNlkM"
}
```

### User Delete

Delete an existing user.

```
DELETE /users/{user_id_or_email}
```


#### Curl Example

```bash
$ curl -n -X DELETE http://localhost:3000/users/$USER_ID_OR_EMAIL \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "1294",
  "first_name": "Nate",
  "updated_at": "2015-01-01T12:00:00Z",
  "last_name": "Pauzenga",
  "city": "Annapolis",
  "state": "Maryland",
  "country": "USA"
}
```

### User Info

Info for existing user.

```
GET /profiles/{user_id_or_email}
```


#### Curl Example

```bash
$ curl -n http://localhost:3000/profiles/$USER_ID_OR_EMAIL
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "first_name": "Nate",
  "last_name": "Pauzenga",
  "email": "test@admin.com",
  "city": "Annapolis",
  "state": "Maryland",
  "country": "USA",
  "password": "helloworld"
}
```

### User List

List existing users.

```
GET /profiles
```


#### Curl Example

```bash
$ curl -n http://localhost:3000/profiles
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
[
  {
    "first_name": "Nate",
    "last_name": "Pauzenga",
    "email": "test@admin.com",
    "city": "Annapolis",
    "state": "Maryland",
    "country": "USA",
    "password": "helloworld"
  }
]
```

### User Update

Update an existing user.

```
PATCH /users/{user_id_or_email}
```

#### Required Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **city** | *string* | city of user | `"Annapolis"` |
| **country** | *string* | country of user | `"USA"` |
| **email** | *string* | unique email of user | `"test@admin.com"` |
| **first_name** | *string* | first name of user | `"Nate"` |
| **last_name** | *string* | last name of user | `"Pauzenga"` |
| **password** | *string* | password of user | `"helloworld"` |
| **state** | *string* | state of user | `"Maryland"` |



#### Curl Example

```bash
$ curl -n -X PATCH http://localhost:3000/users/$USER_ID_OR_EMAIL \
  -d '{
  "first_name": "Nate",
  "last_name": "Pauzenga",
  "email": "test@admin.com",
  "city": "Annapolis",
  "state": "Maryland",
  "country": "USA",
  "password": "helloworld"
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "first_name": "Nate",
  "last_name": "Pauzenga",
  "email": "test@admin.com",
  "city": "Annapolis",
  "state": "Maryland",
  "country": "USA",
  "password": "helloworld"
}
```


