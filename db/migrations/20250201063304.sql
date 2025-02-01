-- Create "contact" table
-- atlas:nolint PG110
CREATE TABLE "contact" (
  "id" bigserial NOT NULL,
  "uuid" uuid NOT NULL DEFAULT gen_random_uuid(),
  "created_at" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "event_id" bigint NOT NULL,
  "email" character varying(255) NOT NULL,
  "phone_number" character varying(20) NOT NULL,
  "address" character varying(255) NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "uq_contact_email" UNIQUE ("email"),
  CONSTRAINT "uq_contact_phone_number" UNIQUE ("phone_number"),
  CONSTRAINT "uq_contact_uuid" UNIQUE ("uuid"),
  CONSTRAINT "fk_contact_event_id" FOREIGN KEY ("event_id") REFERENCES "event" ("id") ON UPDATE NO ACTION ON DELETE RESTRICT,
  CONSTRAINT "ck_contact_phone_number_e164" CHECK ((phone_number)::text ~ '^\+[1-9]\d{1,14}$'::text)
);
-- Create index "idx_contact_email" to table: "contact"
CREATE INDEX "ix_contact_email" ON "contact" ("email");
-- Create index "idx_contact_event_id" to table: "contact"
CREATE INDEX "ix_contact_event_id" ON "contact" ("event_id");
-- Create index "idx_contact_phone" to table: "contact"
CREATE INDEX "ix_contact_phone" ON "contact" ("phone_number");
-- Create index "idx_contact_uuid" to table: "contact"
CREATE INDEX "ix_contact_uuid" ON "contact" ("uuid");
