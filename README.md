# alpinestack

A docker image collection based on alpine

**Image**

```bash
docker pull seancheung/alpinestack:<tag>
```

## Mysql

```bash
docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=mydb seancheung/alpinestack:mysql
docker run -d -p 3306:3306 -p 8080:8080 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=testuser@testdb seancheung/alpinestack:mysql-dev
```

### Tags

| tag                              | description                           |
| -------------------------------- | ------------------------------------- |
| mysql     | latest mysql(mariadb)                 |
| mysql-dev | latest mysql(mariadb) with phpmyadmin |
| mysql-5   | mysql(mariadb) 5.x                    |
| mysql-5.7 | mysql(mariadb) 5.7                    |

### Ports

| port | description       |
| ---- | ----------------- |
| 3306 | mysql server      |
| 8080 | phpmyadmin server |

### Environments

**MYSQL_ROOT_PASSWORD**

Set mysql root password

**MYSQL_USER**

Create one or more user(s). Password will be the same as username if omitted. For multiple user creation, seperate them with ";".

```bash
MYSQL_USER=username:password
MYSQL_USER=username
MYSQL_USER=user1:pass1;user2:pass2
MYSQL_USER=user1;user2
MYSQL_USER=user1:pass1:user2;user3
```

**MYSQL_DATABASE**

Create one or more database(s). Username will be the same as database if omitted. User will be created(with password the same as username) if not exist. For multiple database creation, seperate them with ";".

```bash
MYSQL_DATABASE=username@database
MYSQL_DATABASE=database
MYSQL_DATABASE=username@database1;username@database2
MYSQL_DATABASE=database1;database2
MYSQL_DATABASE=user1@database1;user2@database2;database3
```

## Redis

```bash
docker run -d -p 6379:6379 seancheung/alpinestack:redis
docker run -d -p 6379:6379 -p 8081:8081 seancheung/alpinestack:redis-dev
```

### Tags

| tag                              | description                       |
| -------------------------------- | --------------------------------- |
| redis     | latest redis                      |
| redis-dev | latest redis with redis-commander |
| redis-5   | redis 5.x                         |
| redis-5.0 | redis 5.0                         |

### Ports

| port | description       |
| ---- | ----------------- |
| 6379 | redis server      |
| 8081 | redis-commander server |

## MongoDB

```bash
docker run -d -p 27017:27017 seancheung/alpinestack:mongo
docker run -d -p 27017:27017 -p 8082:8082 seancheung/alpinestack:mongo-dev
```

### Tags

| tag                              | description                       |
| -------------------------------- | --------------------------------- |
| mongo     | latest mongodb                    |
| mongo-dev | latest mongodb with mongo-express |
| mongo-4   | mongodb 4.x                       |
| mongo-4.0 | mongodb 4.0                       |

### Ports

| port | description       |
| ---- | ----------------- |
| 27017 | mongodb server      |
| 8082 | mongo-express server |

## All-in-one

```bash
docker run -d -p 3306:3306 -p 6379:6379 -p 27017:27017 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=mydb seancheung/alpinestack
docker run -d -p 3306:3306 -p 6379:6379 -p 27017:27017 -p 8080-8082:8080-8082 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=mydb seancheung/alpinestack:dev
```

### tags

| tag                              | description                           |
| -------------------------------- | ------------------------------------- |
| latest | latest mysql(mariadb) + redis + mongodb |
| dev | latest mysql(mariadb) + redis + mongodb + phpmyadmin + redis-commander + mongo-express |

