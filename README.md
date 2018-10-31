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