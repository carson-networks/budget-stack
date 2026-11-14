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

## Developing across repos

`make start-local` builds `budget-server` and `web` from sibling checkouts instead of pulling the pinned releases, so changes in several repos can be run together:

```
carson-networks/
  budget/          # web app and iOS app
  budget-server/
  budget-stack/    # this repo
```

```bash
make start-local                      # vendor Go modules, build both images, start the stack
make rebuild-local s=budget-server    # rebuild and restart one service after a change (or s=web)
```

Local images are tagged `:local` ([compose.local.yaml](compose.local.yaml)). Check out whichever branch you want in each sibling repo first. `make start` goes back to the pinned releases.

The iOS Simulator reaches the stack at `http://localhost:8080/api`.
