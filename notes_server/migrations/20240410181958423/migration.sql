BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_user_info" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_user_image" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_google_refresh_token" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_email_reset" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_email_failed_sign_in" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_email_create_request" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_email_auth" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "account" (
    "id" serial PRIMARY KEY,
    "uid" text NOT NULL,
    "email" text NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "scopes" json NOT NULL,
    "blocked" boolean NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "fcm_token" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "fcm_token" (
    "id" serial PRIMARY KEY,
    "accountId" integer NOT NULL,
    "token" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "fcm_token__account_id__unique_idx" ON "fcm_token" USING btree ("accountId");

--
-- ACTION DROP TABLE
--
DROP TABLE "password_update" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "password_update" (
    "id" serial PRIMARY KEY,
    "accountId" integer NOT NULL,
    "validationCodeId" integer NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "password_request__account_id__unique_idx" ON "password_update" USING btree ("accountId");

--
-- ACTION DROP TABLE
--
DROP TABLE "validation_code" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "validation_code" (
    "id" serial PRIMARY KEY,
    "accountId" integer NOT NULL,
    "value" text NOT NULL,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "validation_code__account_id__unique_idx" ON "validation_code" USING btree ("accountId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "fcm_token"
    ADD CONSTRAINT "fcm_token_fk_0"
    FOREIGN KEY("accountId")
    REFERENCES "account"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "password_update"
    ADD CONSTRAINT "password_update_fk_0"
    FOREIGN KEY("accountId")
    REFERENCES "account"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "password_update"
    ADD CONSTRAINT "password_update_fk_1"
    FOREIGN KEY("validationCodeId")
    REFERENCES "validation_code"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "validation_code"
    ADD CONSTRAINT "validation_code_fk_0"
    FOREIGN KEY("accountId")
    REFERENCES "account"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR notes
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('notes', '20240410181958423', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240410181958423', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


--
-- MIGRATION VERSION FOR 'serverpod_auth'
--
DELETE FROM "serverpod_migrations"WHERE "module" IN ('serverpod_auth');

COMMIT;
