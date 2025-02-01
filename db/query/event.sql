-- name: CreateEvent :one
INSERT INTO event (payload)
VALUES ($1)
RETURNING *;

-- name: GetEvent :one
SELECT *
FROM event
WHERE id = $1
LIMIT 1;

-- name: ListEvents :many
SELECT *
FROM event;
