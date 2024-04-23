BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "email_validation_code" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "password_update_request" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "validationCodeId" integer NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "password_update_request__user_id__unique_idx" ON "password_update_request" USING btree ("userId");

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
CREATE UNIQUE INDEX "validation_code__user_id__unique_idx" ON "validation_code" USING btree ("userId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "password_update_request"
    ADD CONSTRAINT "password_update_request_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "password_update_request"
    ADD CONSTRAINT "password_update_request_fk_1"
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
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR notes
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('notes', '20240401143555308', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240401143555308', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240115074239642', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074239642', "timestamp" = now();


COMMIT;
