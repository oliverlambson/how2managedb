variable "url" {
  type     = string
  default  = null
}

locals {
  default_url = "postgres://postgres:postgres@localhost:5436/postgres?search_path=public&sslmode=disable"
  env_url     = getenv("DB_URL")

  url = compact([var.url, local.env_url, local.default_url])[0] # coalesce doesn't exist here
}

env "default" {
  src = "file://db/schema"
  url = local.url
  dev = "docker://postgres/16/dev?search_path=public"

  migration {
    dir = "file://db/migrations"
  }
  format {
    migrate {
      diff = "{{ sql . \"  \" }}"
    }
  }
}

# strict linting
lint {
  latest = 1

  destructive {
    error = true
  }
  non_linear {
    error = true
  }
  data_depend {
    error = true
  }
  incompatible {
    error = true
  }
  concurrent_index {
    error = true
  }
  naming {
    error   = true
    match   = "^[a-z_]+$"
    message = "must be snake_case"
    # ix, uq, fk, ck, pk
    index {
      match   = "^(ix|uq)?_[a-z_]+"
      message = "must be snake_case and start with ix_ (index) or uq_ (unique)"
    }
    foreign_key {
      match   = "^fk_[a-z_]+"
      message = "must be snake_case and start with ix_"
    }
    check {
      match   = "^ck_[a-z_]+"
      message = "must be snake_case and start with ix_"
    }
  }
}
