-- NB: restrict to supported atlas features (tables, indexes, foreign keys, constraints, partitions)

-- event
CREATE TABLE IF NOT EXISTS event (
    id BIGSERIAL PRIMARY KEY,
    uuid UUID DEFAULT gen_random_uuid() NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
    payload JSONB NOT NULL,
    CONSTRAINT uq_event_uuid UNIQUE (uuid)
);
CREATE INDEX ix_event_uuid ON event(uuid);

-- contact
CREATE TABLE IF NOT EXISTS contact (
    id BIGSERIAL PRIMARY KEY,
    uuid UUID DEFAULT gen_random_uuid() NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
    event_id BIGINT NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    address VARCHAR(255) NOT NULL,
    CONSTRAINT fk_contact_event_id FOREIGN KEY (event_id) REFERENCES event (id) ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT uq_contact_uuid UNIQUE (uuid),
    CONSTRAINT uq_contact_email UNIQUE (email),
    CONSTRAINT uq_contact_phone_number UNIQUE (phone_number),
    CONSTRAINT ck_contact_phone_number_e164 CHECK (phone_number ~ '^\+[1-9]\d{1,14}$')
);
CREATE INDEX ix_contact_uuid ON contact(uuid);
CREATE INDEX ix_contact_event_id ON contact(event_id);
CREATE INDEX ix_contact_email ON contact(email);
CREATE INDEX ix_contact_phone ON contact(phone_number);
