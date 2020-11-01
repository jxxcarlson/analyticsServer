# Analytics Server

The purpose of this server is to log POST requests with JSON data like

```
{"userName":  "jxxcarlson", "eventName":  "login", "eventTime":  12234.77}'
```

The route for these requests is `/analytics`.  The  server will also accept
`GET /analytics/hello`, responding with *Yes, I am alive*.

The app is written in Haskel:

```
$ stack build
$ stack run
```

## Testing the app

```
  $ curl -d '{"userName":  "jxxcarlson", "eventName":  "login", "eventTime":  12234.77}' -H 'Content-Type: application/json' http://localhost:8080/analytics
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
- 
To understand aeson, [Article by Artyom Kazak](https://artyom.me/aeson) is the best.

## Miscellaneous references to edit

[Scotty-web](https://github.com/scotty-web/scotty)

[Scotty-wiki](https://github.com/scotty-web/scotty/wiki)

[24 Days of Hackage: scotty](https://ocharles.org.uk/blog/posts/2013-12-05-24-days-of-hackage-scotty.html)

https://github.com/eckyputrady/haskell-scotty-realworld-example-app

https://adit.io/

https://www.robinwieruch.de/postgres-sql-macos-setup

https://trycatchchris.co.uk/post/view/Haskell-Persistent-tutorial-via-GitChapter



