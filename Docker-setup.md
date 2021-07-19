# Docker set-up for Rails applications

## 1. Create folder container_db
`$ mkdir container_db`



## 2. Add placeholder file

`$ touch container_db/ignore.txt`



## 3. Update .gitignore

* add these lines to the .gitignore file:

```
/container_db/
!/container_db/ignore.txt
```




## 4. Change database configuration
- open config/database.yml
- replace development entry with this block:
```
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



## 5. Run docker-compose

`$ docker-compose up`




## 6. Restore database
- copy *.dump file to folder container_db
- connect to database container_db
- go to mounted directory
  `$ cd /var/lib/postgresql/data`
- restore database
  `$ psql -U postgres DBNAME < DBNAME.dump`



## 7. Connect to the Rails app

- open browser and go to http://127.0.0.1:3000/



## 8. Connect VS Code

- open VS Code
- connect to running container_db
- select /workspace as current location
- make changes
- save changes
- check Rails app (step 5) to see if change works