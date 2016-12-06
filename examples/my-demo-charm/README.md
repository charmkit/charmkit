# Overview

DokuWiki is a simple to use and highly versatile Open Source wiki software that
doesn't require a database. It is loved by users for its clean and readable
syntax. The ease of maintenance, backup and integration makes it an
administrator's favorite. Built in access controls and authentication connectors
make DokuWiki especially useful in the enterprise context and the large number
of plugins contributed by its vibrant community allow for a broad range of use
cases beyond a traditional wiki.

# Usage

    $ juju deploy cs:~adam-stokes/dokuwiki

## Login

Initial login and password are

    username: admin
    password: password

# Developing

## Setting up

As long as you have ruby and bundler installed you can do the following:

```
bundle install
bundle exec rake -T
```

All tasks are kept in **Rakefile** and are called via **hooks/{hook-name}**.

# Author

Adam Stokes <adam.stokes@ubuntu.com>

# Copyright

2016 Adam Stokes

# License

MIT
