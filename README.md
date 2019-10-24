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

# Get the application up and running.

## Rails Controllers

- Controller Generation

```
$ docker-compose exec rails_app rails generate controller controller_name
```

- API Controller Generation

```
$ docker-compose exec rails_app rails generate controller api::v1::Users index show new create
```

## Rails Models

```
$ docker-compose exec rails_app rails generate model model_name name:string
```

## Database Manipulations

- Database initialization

```
$ docker-compose exec rails_app bundle exec rails db:create db:migrate db:seed
```

- Database creation

```
$ docker-compose exec rails_app bundle exec rails db:create
```

- Database migration

```
$ docker-compose exec rails_app bundle exec rails db:migrate
```

- Database seed

```
$ docker-compose exec rails_app bundle exec rails db:seed
```

- Remove database

```
$ docker-compose exec rails_app bundle exec rails db:drop
```

- Generate Migration

```
$ docker-compose exec rails_app rails generate migration AddPasswordDigestToUsers password_digest:string
```

## List Rails Routes

```
$ docker-compose exec rails_app rails routes
```

## Rails Testing Frameworks

#### Rails Minitest

```
$ docker-compose exec rails_app rails test
```

#### RSpec, Behaviour Driven Development for Ruby

```
$ docker-compose exec rails_app rspec
```

## Rails Credentials Management

```
$ docker exec -it RAILS_APP_CONTAINER_ID /bin/bash
# which vim
# export EDITOR="vim"
# rails credentials:edit

```
