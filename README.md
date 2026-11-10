# budget-stack

Runs the budget app locally with Docker Compose: Postgres, [budget-server](https://github.com/carson-networks/budget-server), and the [budget](https://github.com/carson-networks/budget) web app.

## Setup

1. Log in to GHCR so the images can be pulled: `docker login ghcr.io`
2. Copy `.env.example` to `.env` and fill in your Plaid keys and a Postgres password.

## Usage

```bash
make start   # pull images and start
make stop    # stop (database is kept in a volume)
make logs    # follow logs
```

The app is at http://localhost:8080 and the API at http://127.0.0.1:9447.
