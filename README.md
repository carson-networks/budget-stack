# budget-stack

Runs the budget app locally with Docker Compose: Postgres, [budget-server](https://github.com/carson-networks/budget-server), and the [budget](https://github.com/carson-networks/budget) web app.

## Setup

Copy `.env.example` to `.env` and fill in your Plaid keys and a Postgres password.

## Usage

```bash
make start   # pull images and start
make stop    # stop (database is kept in a volume)
make logs    # follow logs
```

The app is at http://localhost:8080. The `edge` proxy ([Caddyfile](Caddyfile)) is the only exposed service: it serves the web app and routes `/api/*` to budget-server.

To reach the app by another hostname, set `SITE_HOSTS` in `.env` (space-separated, e.g. `SITE_HOSTS=localhost budget.home.arpa`). Requests for any other host get 403.
