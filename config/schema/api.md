## <a name="resource-game_night"></a>GameNight

The GameNight resource for the API

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | when game_night was created | `"2015-01-01T12:00:00Z"` |
| **id** | *integer* | unique identifier of game_night | `1294` |
| **location_address** | *string* | address of game_night location | `"8401 Fenton st. Silver Spring, MD 20910"` |
| **location_name** | *string* | name of game_night location | `"Silver Spring Library"` |
| **time** | *date-time* | time of game_night | `"2013-09-12 22:49:27 +0530"` |
| **updated_at** | *date-time* | when game_night was updated | `"2015-01-01T12:00:00Z"` |

### GameNight Create

Create a new game_night.

```
POST /game_nights
```

#### Required Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *integer* | unique identifier of game_night | `1294` |
| **location_name** | *string* | name of game_night location | `"Silver Spring Library"` |
| **time** | *date-time* | time of game_night | `"2013-09-12 22:49:27 +0530"` |


#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **location_address** | *string* | address of game_night location | `"8401 Fenton st. Silver Spring, MD 20910"` |


#### Curl Example

```bash
$ curl -n -X POST http://localhost:3000/game_nights \
  -d '{
  "id": 1294,
  "location_name": "Silver Spring Library",
  "location_address": "8401 Fenton st. Silver Spring, MD 20910",
  "time": "2013-09-12 22:49:27 +0530"
}' \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer: iOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NTM5MzkwMjYsImF1ZCI6bnVsbCwic3ViIjoxfQ.TSgJie1vAWxR_ym_uazjKs43rpQ50OKmb2KZ2N6ALs4"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
{
  "id": 1294,
  "location_name": "Silver Spring Library",
  "location_address": "8401 Fenton st. Silver Spring, MD 20910",
  "time": "2013-09-12 22:49:27 +0530"
}
```

### GameNight Delete

Delete an existing game_night.

```
DELETE /game_nights/{game_night_id}
```


#### Curl Example

```bash
$ curl -n -X DELETE http://localhost:3000/game_nights/$GAME_NIGHT_ID \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer: iOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NTM5MzkwMjYsImF1ZCI6bnVsbCwic3ViIjoxfQ.TSgJie1vAWxR_ym_uazjKs43rpQ50OKmb2KZ2N6ALs4"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": 1294,
  "location_name": "Silver Spring Library",
  "location_address": "8401 Fenton st. Silver Spring, MD 20910",
  "time": "2013-09-12 22:49:27 +0530",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### GameNight Info

Info for existing game_night.

```
GET /game_nights/{game_night_id}
```


#### Curl Example

```bash
$ curl -n http://localhost:3000/game_nights/$GAME_NIGHT_ID \
  -H "Authorization: Bearer: iOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NTM5MzkwMjYsImF1ZCI6bnVsbCwic3ViIjoxfQ.TSgJie1vAWxR_ym_uazjKs43rpQ50OKmb2KZ2N6ALs4"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": 1294,
  "location_name": "Silver Spring Library",
  "location_address": "8401 Fenton st. Silver Spring, MD 20910",
  "time": "2013-09-12 22:49:27 +0530"
}
```

### GameNight List

List existing game_nights.

```
GET /game_nights
```


#### Curl Example

```bash
$ curl -n http://localhost:3000/game_nights \
  -H "Authorization: Bearer: iOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NTM5MzkwMjYsImF1ZCI6bnVsbCwic3ViIjoxfQ.TSgJie1vAWxR_ym_uazjKs43rpQ50OKmb2KZ2N6ALs4"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
[
  {
    "id": 1294,
    "location_name": "Silver Spring Library",
    "location_address": "8401 Fenton st. Silver Spring, MD 20910",
    "time": "2013-09-12 22:49:27 +0530"
  }
]
```

### GameNight Update

Update an existing game_night.

```
PATCH /game_nights/{game_night_id}
```

#### Required Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *integer* | unique identifier of game_night | `1294` |
| **location_name** | *string* | name of game_night location | `"Silver Spring Library"` |
| **time** | *date-time* | time of game_night | `"2013-09-12 22:49:27 +0530"` |


#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **location_address** | *string* | address of game_night location | `"8401 Fenton st. Silver Spring, MD 20910"` |


#### Curl Example

```bash
$ curl -n -X PATCH http://localhost:3000/game_nights/$GAME_NIGHT_ID \
  -d '{
  "id": 1294,
  "location_name": "Silver Spring Library",
  "location_address": "8401 Fenton st. Silver Spring, MD 20910",
  "time": "2013-09-12 22:49:27 +0530"
}' \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer: iOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NTM5MzkwMjYsImF1ZCI6bnVsbCwic3ViIjoxfQ.TSgJie1vAWxR_ym_uazjKs43rpQ50OKmb2KZ2N6ALs4"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": 1294,
  "location_name": "Silver Spring Library",
  "location_address": "8401 Fenton st. Silver Spring, MD 20910",
  "time": "2013-09-12 22:49:27 +0530"
}
```


## <a name="resource-group"></a>Group

The Group resource for the API

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **city** | *string* | city of group | `"Baltimore"` |
| **country** | *string* | country of group | `"USA"` |
| **created_at** | *date-time* | when group was created | `"2015-01-01T12:00:00Z"` |
| **facebook** | *string* | facebook of group | `"www.facebook.com/waagh"` |
| **id** | *integer* | unique identifier of group | `1294` |
| **name** | *string* | name of group | `"Warhamer Wednesdays"` |
| **state** | *string* | state of group | `"MD"` |
| **twitter** | *string* | twitter of group | `"@waagh"` |
| **updated_at** | *date-time* | when group was updated | `"2015-01-01T12:00:00Z"` |

### Group Create

Create a new group.

```
POST /groups
```

#### Required Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *integer* | unique identifier of group | `1294` |
| **name** | *string* | name of group | `"Warhamer Wednesdays"` |


#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **city** | *string* | city of group | `"Baltimore"` |
| **country** | *string* | country of group | `"USA"` |
| **facebook** | *string* | facebook of group | `"www.facebook.com/waagh"` |
| **state** | *string* | state of group | `"MD"` |
| **twitter** | *string* | twitter of group | `"@waagh"` |


#### Curl Example

```bash
$ curl -n -X POST http://localhost:3000/groups \
  -d '{
  "id": 1294,
  "name": "Warhamer Wednesdays",
  "city": "Baltimore",
  "state": "MD",
  "country": "USA",
  "facebook": "www.facebook.com/waagh",
  "twitter": "@waagh"
}' \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer: iOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NTM5MzkwMjYsImF1ZCI6bnVsbCwic3ViIjoxfQ.TSgJie1vAWxR_ym_uazjKs43rpQ50OKmb2KZ2N6ALs4"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
{
  "id": 1294,
  "name": "Warhamer Wednesdays",
  "city": "Baltimore",
  "state": "MD",
  "country": "USA",
  "facebook": "www.facebook.com/waagh",
  "twitter": "@waagh"
}
```

### Group Delete

Delete an existing group.

```
DELETE /groups/{group_id}
```


#### Curl Example

```bash
$ curl -n -X DELETE http://localhost:3000/groups/$GROUP_ID \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer: iOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NTM5MzkwMjYsImF1ZCI6bnVsbCwic3ViIjoxfQ.TSgJie1vAWxR_ym_uazjKs43rpQ50OKmb2KZ2N6ALs4"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": 1294,
  "name": "Warhamer Wednesdays",
  "updated_at": "2015-01-01T12:00:00Z",
  "city": "Baltimore",
  "state": "MD",
  "country": "USA",
  "facebook": "www.facebook.com/waagh",
  "twitter": "@waagh"
}
```

### Group Info

Info for existing group.

```
GET /groups/{group_id}
```


#### Curl Example

```bash
$ curl -n http://localhost:3000/groups/$GROUP_ID \
  -H "Authorization: Bearer: iOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NTM5MzkwMjYsImF1ZCI6bnVsbCwic3ViIjoxfQ.TSgJie1vAWxR_ym_uazjKs43rpQ50OKmb2KZ2N6ALs4"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": 1294,
  "name": "Warhamer Wednesdays",
  "city": "Baltimore",
  "state": "MD",
  "country": "USA",
  "facebook": "www.facebook.com/waagh",
  "twitter": "@waagh"
}
```

### Group List

List existing groups.

```
GET /groups
```


#### Curl Example

```bash
$ curl -n http://localhost:3000/groups \
  -H "Authorization: Bearer: iOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NTM5MzkwMjYsImF1ZCI6bnVsbCwic3ViIjoxfQ.TSgJie1vAWxR_ym_uazjKs43rpQ50OKmb2KZ2N6ALs4"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
[
  {
    "id": 1294,
    "name": "Warhamer Wednesdays",
    "city": "Baltimore",
    "state": "MD",
    "country": "USA",
    "facebook": "www.facebook.com/waagh",
    "twitter": "@waagh"
  }
]
```

### Group Update

Update an existing group.

```
PATCH /groups/{group_id}
```

#### Required Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *integer* | unique identifier of group | `1294` |
| **name** | *string* | name of group | `"Warhamer Wednesdays"` |


#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **city** | *string* | city of group | `"Baltimore"` |
| **country** | *string* | country of group | `"USA"` |
| **facebook** | *string* | facebook of group | `"www.facebook.com/waagh"` |
| **state** | *string* | state of group | `"MD"` |
| **twitter** | *string* | twitter of group | `"@waagh"` |


#### Curl Example

```bash
$ curl -n -X PATCH http://localhost:3000/groups/$GROUP_ID \
  -d '{
  "id": 1294,
  "name": "Warhamer Wednesdays",
  "city": "Baltimore",
  "state": "MD",
  "country": "USA",
  "facebook": "www.facebook.com/waagh",
  "twitter": "@waagh"
}' \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer: iOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NTM5MzkwMjYsImF1ZCI6bnVsbCwic3ViIjoxfQ.TSgJie1vAWxR_ym_uazjKs43rpQ50OKmb2KZ2N6ALs4"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": 1294,
  "name": "Warhamer Wednesdays",
  "city": "Baltimore",
  "state": "MD",
  "country": "USA",
  "facebook": "www.facebook.com/waagh",
  "twitter": "@waagh"
}
```


## <a name="resource-user"></a>User

The User resource for the API

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **city** | *string* | city of user | `"Annapolis"` |
| **country** | *string* | country of user | `"USA"` |
| **created_at** | *date-time* | when user was created | `"2015-01-01T12:00:00Z"` |
| **first_name** | *string* | first name of user | `"Nate"` |
| **id** | *string* | unique identifier of user | `"1294"` |
| **last_name** | *string* | last name of user | `"Pauzenga"` |
| **state** | *string* | state of user | `"Maryland"` |
| **updated_at** | *date-time* | when user was updated | `"2015-01-01T12:00:00Z"` |

### User Create

Create a new user.

```
POST /user
```

#### Required Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **city** | *string* | city of user | `"Annapolis"` |
| **country** | *string* | country of user | `"USA"` |
| **email** | *string* | unique email of user | `"test@admin.com"` |
| **first_name** | *string* | first name of user | `"Nate"` |
| **id** | *string* | unique identifier of user | `"1294"` |
| **last_name** | *string* | last name of user | `"Pauzenga"` |
| **password** | *string* | password of user | `"helloworld"` |
| **state** | *string* | state of user | `"Maryland"` |



#### Curl Example

```bash
$ curl -n -X POST http://localhost:3000/user \
  -d '{
  "id": "1294",
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
DELETE /user/{user_id_or_email}
```


#### Curl Example

```bash
$ curl -n -X DELETE http://localhost:3000/user/$USER_ID_OR_EMAIL \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer: iOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NTM5MzkwMjYsImF1ZCI6bnVsbCwic3ViIjoxfQ.TSgJie1vAWxR_ym_uazjKs43rpQ50OKmb2KZ2N6ALs4"
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
$ curl -n http://localhost:3000/profiles/$USER_ID_OR_EMAIL \
  -H "Authorization: Bearer: iOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NTM5MzkwMjYsImF1ZCI6bnVsbCwic3ViIjoxfQ.TSgJie1vAWxR_ym_uazjKs43rpQ50OKmb2KZ2N6ALs4"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": "1294",
  "first_name": "Nate",
  "last_name": "Pauzenga",
  "email": "test@admin.com",
  "city": "Annapolis",
  "state": "Maryland",
  "country": "USA"
}
```

### User List

List existing users.

```
GET /profiles
```


#### Curl Example

```bash
$ curl -n http://localhost:3000/profiles \
  -H "Authorization: Bearer: iOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NTM5MzkwMjYsImF1ZCI6bnVsbCwic3ViIjoxfQ.TSgJie1vAWxR_ym_uazjKs43rpQ50OKmb2KZ2N6ALs4"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
[
  {
    "id": "1294",
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
PATCH /user/{user_id_or_email}
```

#### Required Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **city** | *string* | city of user | `"Annapolis"` |
| **country** | *string* | country of user | `"USA"` |
| **email** | *string* | unique email of user | `"test@admin.com"` |
| **first_name** | *string* | first name of user | `"Nate"` |
| **id** | *string* | unique identifier of user | `"1294"` |
| **last_name** | *string* | last name of user | `"Pauzenga"` |
| **password** | *string* | password of user | `"helloworld"` |
| **state** | *string* | state of user | `"Maryland"` |



#### Curl Example

```bash
$ curl -n -X PATCH http://localhost:3000/user/$USER_ID_OR_EMAIL \
  -d '{
  "id": "1294",
  "first_name": "Nate",
  "last_name": "Pauzenga",
  "email": "test@admin.com",
  "city": "Annapolis",
  "state": "Maryland",
  "country": "USA",
  "password": "helloworld"
}' \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer: iOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NTM5MzkwMjYsImF1ZCI6bnVsbCwic3ViIjoxfQ.TSgJie1vAWxR_ym_uazjKs43rpQ50OKmb2KZ2N6ALs4"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": "1294",
  "first_name": "Nate",
  "last_name": "Pauzenga",
  "email": "test@admin.com",
  "city": "Annapolis",
  "state": "Maryland",
  "country": "USA"
}
```


