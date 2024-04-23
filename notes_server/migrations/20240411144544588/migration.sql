BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "account" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "fcm_token" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "fcm_token" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "token" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "fcm_token__account_id__unique_idx" ON "fcm_token" USING btree ("userId");

--
-- ACTION DROP TABLE
--
DROP TABLE "password_update" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "password_update" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "validationCodeId" integer NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "password_request__account_id__unique_idx" ON "password_update" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user" (
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
DROP TABLE "validation_code" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "validation_code" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "value" text NOT NULL,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "validation_code__account_id__unique_idx" ON "validation_code" USING btree ("userId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "fcm_token"
    ADD CONSTRAINT "fcm_token_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "password_update"
    ADD CONSTRAINT "password_update_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
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
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR notes
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('notes', '20240411144544588', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240411144544588', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
