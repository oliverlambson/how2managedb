-- Create "event" table
-- atlas:nolint PG110
CREATE TABLE "event" (
  "id" bigserial NOT NULL,
  "uuid" uuid NOT NULL DEFAULT gen_random_uuid(),
  "created_at" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "payload" jsonb NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "uq_event_uuid" UNIQUE ("uuid")
);
-- Create index "idx_event_uuid" to table: "event"
CREATE INDEX "ix_event_uuid" ON "event" ("uuid");
