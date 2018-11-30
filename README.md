# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

## System dependencies

* Ruby 2.5.1
* Rails 5.2.1
* Postgres 9.5

## Setup

```
$ git clone git@github.com:ivanbalingit/simple_organizer_api.git
$ cd simple_organizer_api
$ bundle
```

## How to setup the database
After you have successfully installed Postgres, login to the console:
```
$ sudo -u postgres psql
```
Create a user with username ```simple_organizer_api``` and password ```password```:
```
=# create user simple_organizer_api with password 'password';  
``` 
Make user ```simple_organizer_api``` superuser:
```
=# alter role simple_organizer_api superuser createrole createdb replication; 
```
In order to use the console as user ```simple_organizer_api```, create a database for the user:
```
$ sudo -u postgres createdb simple_organizer_api
$ sudo -u postgres psql
=# grant all privileges on database simple_organizer_api to simple_organizer_api;
```
Finally, initialize the database for Rails:
```
$ rails db:setup db:migrate
```

## Deployment instructions
