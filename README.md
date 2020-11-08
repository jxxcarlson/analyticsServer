# Analytics Server

The purpose of this server is to log POST requests with JSON data like

```
{"id": -1, userName":  "jxxcarlson", "eventName":  "login", "eventTime":  12234.77}'
```

Here the value of the id field is a dummy which will be replaced when a record
is inserted in the database.

The route for these requests is `/analytics`.  The  server will also accept
`GET /analytics/hello`, responding with *Yes, I am alive*.

The app is written in Haskell:

```
$ stack build
$ stack run
```

## Testing the app

```
  curl -d '{"id": -1, "username":  "jxxcarlson", "eventname":  "login", "eventtime":  12234.77}' -H 'Content-Type: application/json' http://127.0.0.1:3001/analytics

  curl http://127.0.0.1:3001/analytics
  
  curl -d '{"id": -1, "userName":  "jxxcarlson", "eventname":  "login", "eventtime":  30001.77}' -H 'Content-Type: application/json' http://localhost:8080/analytics'
```

```
su - jxx
psql
drop table events;
create table events (id serial primary key, username text, session text, eventname text, eventtime float);
insert into events(username, session, eventname, eventtime) values('ichabod', 'yh7nn3', 'signin', 1234.65);
select * from events;
```

## Postgres

Postgres is installed at `/usr/local/var/postgres`

```
 $ createdb --username=jxx --password forscotty
 $ dropdb forscotty
```

To start postgress, use `brew services start postgresql`.
Or, if you don't want/need a background service you can just run`pg_ctl -D /usr/local/var/postgres start`

Make a Postgres user with `createuser -s test -W`

## Development references

The reference on which this app is based is [Rest api in Haskell](https://mcksp.com/rest-api-in-haskell). A simple,
straightforward approach.  I had also looked at the following:

- [PRACTICAL HASKELL - BUILDING A JSON API](http://seanhess.github.io/2015/08/19/practical-haskell-json-api.html)

- [Scotty and Persistent](https://www.parsonsmatt.org/2015/05/02/scotty_and_persistent.html)

- [How to write a Haskell web service (from scratch) - Part 3](https://dev.to/parambirs/how-to-write-a-haskell-web-servicefrom-scratch---part-3-5en6)
  
- [Scotty & Postgres-Simple](https://github.com/jorgen/scotty-postgres)
  
To understand aeson, [Article by Artyom Kazak](https://artyom.me/aeson) is the best.


