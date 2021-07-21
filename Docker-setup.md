# Docker set-up for Rails applications

## 1. Create folder container_db
`$ mkdir container_db`




## 2. Change database configuration
- open config/database.yml
- replace development entry with this block:
```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: postgres
  password: password
  pool: 5
  min_messages: warning

development:
  <<: *default
  database: DBNAME

```



## 3. Create Dockerfile

* create a Dockerfile in the root folder - change ruby version to the one you need (see .ruby-version):

  ```dockerfile
  FROM ruby:2.5.3
  RUN apt-get update
  #RUN apt-get install -y yarnpkg
  #RUN ln -s /usr/bin/yarnpkg /usr/local/bin/yarn
  RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
  WORKDIR /myapp
  COPY Gemfile /myapp/Gemfile
  COPY Gemfile.lock /myapp/Gemfile.lock
  RUN gem install bundler
  RUN bundle install
  ```

  



## 4. Create docker-compose.yml

* create a docker-compose.yaml in the root folder:

  ```yaml
  version: "3.2"
  services:
    db:
      image: postgres
      volumes:
        - ./container_db:/var/lib/postgresql/data
      environment:
        POSTGRES_PASSWORD: password
      ports:
        - 5432:5432
    app:
      build:
          context: .
          dockerfile: Dockerfile
      volumes:
        - type: bind
          source: .
          target: /workspace
      working_dir: /workspace
      command: bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
      ports:
        - "3000:3000"
      depends_on:
        - db
  ```

  



## 5. Run docker-compose

`$ docker-compose up`




## 6. Restore database
- copy *.dump file to folder container_db
- connect to database container_db
- go to mounted directory
  `$ cd /var/lib/postgresql/data`
- create the database 
  `$ createdb -T template0 DBNAME`
- restore database
  `$ psql -U postgres DBNAME < DBNAME.dump`



## 7. Connect to the Rails app

- open browser and go to http://127.0.0.1:3000/



## 8. Add placeholder file

`$ touch container_db/ignore.txt`



## 9. Update .gitignore

* add these lines to the .gitignore file:

```
container_db/*
!container_db/ignore.txt
```



## 10. Connect VS Code

- open VS Code
- connect to running container_db
- select /workspace as current location
- make changes
- save changes
- check Rails app (step 5) to see if change works

