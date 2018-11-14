# Rails Tongoute API

## Install

### Clone repository

```
git clone https://github.com/fon-Luchs/Tongoute-api.git
```

### Install gems

```
gem install bundler
```

```
bundle install
```

### Create databases

```
rake db:create
```

### Run migrations

```
rake db:migrate
```

### Run specs

```
rake
```

### Run server

```
rails s
```

### Sing Up

```
curl -H 'Accept: application/json' \
     -d 'user[email]=john@mcclane.com&user[password]=123456&user[password_confirmation]=123456' \
     -d 'user[first_name]=Ibrahim&user[last_name]=Nurglit' \
      localhost:3000/api/profile
```

### Sing In

```
curl -H 'Accept: application/json' \
     -d 'session[email]=john@mcclane.com&session[password]=123456' \
      localhost:3000/api/session
```

### Profile Show

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/profile
```

### Profile Update

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'user[first_name]=Jarry&user[last_name]=Smith' \
     -d 'user[date]=24.12.1997&user[number]=1234567890' \
     -d 'user[address]=Apple str. 13&user[about]=Some informations' \
     -d 'user[country]=USA&user[locate]=New York' \
     -X PUT localhost:3000/api/profile


curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'user[first_name]=John& \
     -X PATCH localhost:3000/api/profile
```

### Profile Delete

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X DELETE localhost:3000/api/profile
```

### User Show

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/users/:id
```

### User Index

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/users/
```

### Note Create

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'note[title]=My first title&note[body]=My first title' \
      localhost:3000/api/profile/notes
```

### Note Update

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'note[title]=My first title&note[body]=My first title' \
      localhost:3000/api/profile/notes/:id
```

### Note Show

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/profile/notes/:id
```

### Note Index

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/profile/notes/
```

### Note Delete

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X DELETE localhost:3000/api/profile/notes/:id
```

### Wall Create Post

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'post[title]=My first title&post[body]=My first title' \
      localhost:3000/api/profile/walls

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'post[title]=My first title&post[body]=My first title' \
      localhost:3000/api/user/:user_id/walls
```

### Wall Show Post

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/profile/walls/:id

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/user/:user_id/walls/:id
```

### Wall Index

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/profile/walls/

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/user/:user_id/walls/
```

### Wall Update Post

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'post[title]=My first title&post[body]=My first title' \
      localhost:3000/api/profile/walls/:id

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'post[title]=My first title&post[body]=My first title' \
      localhost:3000/api/user/:user_id/walls/:id
```

### Wall Delete Post

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X DELETE localhost:3000/api/profile/walls/:id

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X DELETE localhost:3000/api/user/:user_id/walls/:id
```

### Subscriber Create

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X POST localhost:3000/api/users/:id/request
```

### Subscriber Show

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/profile/subscribers/:id
```

### Subscriber Index

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/profile/subscribers

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/users/:id/subscribers
```

### Add User in black list

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X POSTlocalhost:3000/api/users/:id/block

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X POST localhost:3000/api/profile/subscribers/:id/block

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X POST localhost:3000/api/profile/friends/:id/block
```

### Black List Index

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/profile/blacklist/
```

### User Show in black list

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/profile/blacklist/:id
```

### Remove User from black list

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X DELETE localhost:3000/api/users/:id/unblock

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X DELETE localhost:3000/api/profile/subscribers/:id/unblock

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X DELETE localhost:3000/api/profile/friends/:id/unblock
```
