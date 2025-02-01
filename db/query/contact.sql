-- name: CreateContact :one
INSERT INTO contact (event_id, email, phone_number)
VALUES ($1, $2, $3)
RETURNING *;

-- name: GetContact :one
SELECT *
FROM contact
WHERE id = $1
LIMIT 1;

-- name: ListContacts :many
SELECT *
FROM contact;
