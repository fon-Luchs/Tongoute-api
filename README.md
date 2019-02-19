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

### Subscriber Show

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/profile/subscribers/:id

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/users/:id/subscribers/:id
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

### Subscribed show

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/profile/subscribings/:id
```

### Subscribed index

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/profile/subscribings
```

### Subscribed create

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X POST localhost:3000/api/users/:id/request
```

### Friend create

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X POST localhost:3000/api/users/:id/accept

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X POST localhost:3000/api/profile/subscribings/:id/accept
```

### Friend show

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/users/:id/friends/:id

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/profile/friends/:id
```

### Friend index

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/users/:id/friends

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/profile/friends
```

### Friend Delete

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X DELETE localhost:3000/api/profile/friends/:id/remove

```

### Add User in black list

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X POST localhost:3000/api/users/:id/block

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

### Conversation create

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X POST localhost:3000/api/users/:user_id/conversations

```

### Conversation index

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/users/:user_id/conversations

```

### Conversation show

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/api/users/:user_id/conversations/:id

```

### Chat create

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'chat[name]=Tongoute' \
     localhost:3000/api/profile/chats/
```

### Chat update

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'chat[name]=Tongoute' \
     -X PUT localhost:3000/api/profile/chats/:id
```

### Chat index

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     localhost:3000/api/profile/chats/
```

### Chat show

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     localhost:3000/api/profile/chats/:id
```

### Chat destroy

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X DELETE localhost:3000/api/profile/chats/:id
```

### Chat Join

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X POST localhost:3000/api/profile/chats/:id/join
```

### Chat Leave

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -X POST localhost:3000/api/profile/chats/:id/leave
```

### Create Message

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'message[text]=Hello Tongoute' \
     localhost:3000/api/profile/chats/:chat_id/messages

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'message[text]=Hi)' \
      localhost:3000/api/profile/conversations/:conversation_id/messages
```

### Update Message

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'message[text]=Hello Tongoute' \
     -X PATCH localhost:3000/api/profile/chats/:chat_id/messages/:id

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'message[text]=Hi)' \
     -X PATCH localhost:3000/api/profile/conversations/:conversation_id/messages/:id
```
