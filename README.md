# Prerequisites

- docker-compose
- Ruby 2.6.3
- Rails 6.0.0

# Development Mode

#### Environment variables

```
$ export COMPOSE_FILE=docker-compose.dev.yml
```

#### Spinning up containers

```
$ docker-compose build --no-cache
$ docker-compose up
```

#### Rebuild and spin up containers

```
$ docker-compose up --build
```