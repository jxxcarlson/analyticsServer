# analyticsServer


[Scotty-web](https://github.com/scotty-web/scotty)

[Scotty-wiki](https://github.com/scotty-web/scotty/wiki)




[24 Days of Hackage: scotty](https://ocharles.org.uk/blog/posts/2013-12-05-24-days-of-hackage-scotty.html)

https://github.com/eckyputrady/haskell-scotty-realworld-example-app

https://adit.io/

https://www.robinwieruch.de/postgres-sql-macos-setup

https://trycatchchris.co.uk/post/view/Haskell-Persistent-tutorial-via-GitChapter














icu4c is keg-only, which means it was not symlinked into /usr/local,
because macOS provides libicucore.dylib (but nothing else).

If you need to have icu4c first in your PATH run:
  echo 'export PATH="/usr/local/opt/icu4c/bin:$PATH"' >> ~/.zshrc
  echo 'export PATH="/usr/local/opt/icu4c/sbin:$PATH"' >> ~/.zshrc

For compilers to find icu4c you may need to set:
  export LDFLAGS="-L/usr/local/opt/icu4c/lib"
  export CPPFLAGS="-I/usr/local/opt/icu4c/include"

For pkg-config to find icu4c you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig"

==> Summary
🍺  /usr/local/Cellar/icu4c/67.1: 258 files, 71.2MB
==> Installing postgresql dependency: openssl@1.1
==> Pouring openssl@1.1-1.1.1h.catalina.bottle.tar.gz
==> Caveats
A CA file has been bootstrapped using certificates from the system
keychain. To add additional certificates, place .pem files in
  /usr/local/etc/openssl@1.1/certs

and run
  /usr/local/opt/openssl@1.1/bin/c_rehash

openssl@1.1 is keg-only, which means it was not symlinked into /usr/local,
because macOS provides LibreSSL.

If you need to have openssl@1.1 first in your PATH run:
  echo 'export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"' >> ~/.zshrc

For compilers to find openssl@1.1 you may need to set:
  export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
  export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"

For pkg-config to find openssl@1.1 you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

==> Summary
🍺  /usr/local/Cellar/openssl@1.1/1.1.1h: 8,067 files, 18.5MB
==> Installing postgresql dependency: krb5
==> Pouring krb5-1.18.2.catalina.bottle.tar.gz
==> Caveats
krb5 is keg-only, which means it was not symlinked into /usr/local,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have krb5 first in your PATH run:
  echo 'export PATH="/usr/local/opt/krb5/bin:$PATH"' >> ~/.zshrc
  echo 'export PATH="/usr/local/opt/krb5/sbin:$PATH"' >> ~/.zshrc

For compilers to find krb5 you may need to set:
  export LDFLAGS="-L/usr/local/opt/krb5/lib"
  export CPPFLAGS="-I/usr/local/opt/krb5/include"

For pkg-config to find krb5 you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/krb5/lib/pkgconfig"

==> Summary
🍺  /usr/local/Cellar/krb5/1.18.2: 162 files, 4.0MB
==> Installing postgresql
==> Pouring postgresql-13.0.catalina.bottle.tar.gz
==> /usr/local/Cellar/postgresql/13.0/bin/initdb --locale=C -E UTF-8 /usr/local/var/postgres
==> Caveats
To migrate existing data from a previous major version of PostgreSQL run:
  brew postgresql-upgrade-database

This formula has created a default database cluster with:
  initdb --locale=C -E UTF-8 /usr/local/var/postgres
For more details, read:
  https://www.postgresql.org/docs/13/app-initdb.html

To have launchd start postgresql now and restart at login:
  brew services start postgresql
Or, if you don't want/need a background service you can just run:
  pg_ctl -D /usr/local/var/postgres start
==> Summary
🍺  /usr/local/Cellar/postgresql/13.0: 3,216 files, 42.6MB
==> Upgrading 1 dependent:
unbound 1.11.0 -> 1.12.0
==> Upgrading unbound 1.11.0 -> 1.12.0
==> Downloading https://homebrew.bintray.com/bottles/unbound-1.12.0.catalina.bottle.tar.gz
==> Downloading from https://d29vzk4ow07wi7.cloudfront.net/c5c89b6f51314d30ed291f08f195f6733bc756a2244b024cc4a08971137b2442?response-content-disposition=attachment%3Bfilename%3D%22unbound-1.12.0.ca
######################################################################## 100.0%
==> Pouring unbound-1.12.0.catalina.bottle.tar.gz
==> Caveats
To have launchd start unbound now and restart at startup:
  sudo brew services start unbound
==> Summary
🍺  /usr/local/Cellar/unbound/1.12.0: 57 files, 5.4MB
Removing: /usr/local/Cellar/unbound/1.11.0... (57 files, 5.2MB)
Removing: /Users/jxxcarlson/Library/Caches/Homebrew/unbound--1.11.0.catalina.bottle.tar.gz... (2.6MB)
==> Checking for dependents of upgraded formulae...
Error: No such file or directory - /usr/local/Cellar/unbound/1.11.0