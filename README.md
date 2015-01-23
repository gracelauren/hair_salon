Hair Salon Database
==============

by Grace Mekarski

Hair Salon Database is an app that uses a database and Sinatra to allow owners to add stylists and clients for each stylist for their business records.

Installation
------------

Install Hair Salon Database by first cloning the repository.  
```
$ git clone http://github.com/gracelauren/hair_salon.git
```

Install all of the required gems:
```
$ bundle install
```

Start the database:
```
$ postgres
```

Create the databases and tables:
```
# psql
```

```
username=# CREATE DATABASE hair_salon;
```

```
username=# \c hair_salon;
```

```
todo=# CREATE TABLE stylists (id serial PRIMARY KEY, name varchar);
```

```
todo=# CREATE TABLE clients (id serial PRIMARY KEY, name varchar, stylist_id int);
```

```
todo=# CREATE DATABASE hair_salon_test WITH TEMPLATE hair_salon;
```

Start the webserver:
```
$ ruby app.rb
```

In your web browser, go to http://localhost:4567

License
-------

GNU GPL v2. Copyright 2015 Grace Mekarski
