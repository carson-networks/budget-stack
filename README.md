# budget-stack

Runs the budget app locally with Docker Compose: Postgres, [budget-server](https://github.com/carson-networks/budget-server), and the [budget](https://github.com/carson-networks/budget) web app.

## Setup

Copy `.env.example` to `.env` and fill in your Plaid keys and a Postgres password.

## Usage

```bash
make start         # pull the pinned releases and start
make start-local   # build budget-server and web from ../budget-server and ../budget, start; rerun after changes
make stop          # stop (database is kept in a volume)
make logs          # follow logs
```

The app is at http://localhost:8080. The `edge` proxy ([Caddyfile](Caddyfile)) is the only exposed service: it serves the web app and routes `/api/*` to budget-server.

To reach the app by another hostname, set `SITE_HOSTS` in `.env` (space-separated, e.g. `SITE_HOSTS=localhost budget.home.arpa`). Requests for any other host get 403.

## Developing across repos

[compose.yaml](compose.yaml) has two profiles. `release` runs the pinned `web` and `budget-server` images; `local` runs `web-local` and `budget-server-local`, built from sibling checkouts of whatever branch each is on:

```
carson-networks/
  budget/          # web app and iOS app
  budget-server/
  budget-stack/    # this repo
```

Postgres and `edge` are shared, so the database carries over when switching. `make start` and `make start-local` each stop the other profile's services first.

The iOS Simulator reaches the stack at `http://localhost:8080/api`.
