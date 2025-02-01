# an alternative db approach for python

I'm testing out [sqlc](https://github.com/sqlc-dev/sqlc-gen-python) instead of sqlalchemy orm,
and [atlas](https://atlasgo.io/docs) instead of alembic.
(I'm really not enjoying sqlalchemy + alembic.)

## prerequisites

- [sqlc](https://docs.sqlc.dev/en/latest/overview/install.html)
- [atlas](https://atlasgo.io/getting-started/#installation)
- [uv](https://docs.astral.sh/uv/getting-started/installation/)

## repo map

```
.
├── db
│   ├── migrations       # (1b) generate migrations (`atlas ...`)
│   │   ├── 20250201012041.sql
│   │   ├── ...
│   │   └── atlas.sum
│   ├── query            # (2a) define queries needed in python lib
│   │   ├── contact.sql
│   │   ├── event.sql
│   │   └── ...
│   └── schema           # (1a) define schema
│       ├── functions.sql
│       ├── tables.sql
│       ├── types.sql
│       ├── views-materialzed.sql
│       └── views.sql
├── src
│   ├── db               # (2b) generate python lib for db queries (`sqlc ...`)
│   │   ├── __init__.py
│   │   ├── models.py    # - pydantic models of tables
│   │   ├── contact.py   # - contact.sql queries
│   │   ├── event.py     # - event.sql queries
│   │   └── ...          # - ... queries
│   └── ...
├── atlas.hcl # atlas config (generates db/migrations sql scripts)
├── sqlc.yaml # sqlc config (generates src/db python module)
└── ...
```

## set up dev env

```shell
docker compose up -d
```

## cli

- migrations (`atlas`)
  - auto-generate new migration script `atlas migrate diff --env default`
  - manually-generate new migration script `atlas migrate new --env default`
  - lint migration script `atlas migrate lint --env default`
  - run migration scripts `atlas migrate apply --env default`
  - re-generate atlas.sum after modifying migration scripts `atlas migrate hash --env default`
- sql <> python (`sqlc`)
  - generate python `sqlc generate`
  - check generated python up-to-date `sqlc diff`
  - type check queries `sqlc compile`
  - lint queries `sqlc vet`

## gotchas

### atlas

Atlas only supports some constructs (the rest are part of the pro plan, which I'm not going to pay for):

| Supported          | Unsupported        |
| ------------------ | ------------------ |
| Tables and Columns | Views              |
| Indexes            | Materialized Views |
| Foreign Keys       | Stored Procedures  |
| Constraints        | Functions          |
| Partitions         | Triggers           |

This is fine because it'll still apply them if you manually add them to the migrations,
which is what you'd have to do anyway with other migration tools.

### sqlc

You can't run a formatter on the generated python files or sqlc diff will return non-zero.
