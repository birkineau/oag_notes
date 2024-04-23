BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "user_account_validation_code" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "email_validation_code" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "code" text NOT NULL,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "email_validation_code_user_id_unique" ON "email_validation_code" USING btree ("userId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "email_validation_code"
    ADD CONSTRAINT "email_validation_code_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR notes
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('notes', '20240327100653316', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240327100653316', "timestamp" = now();

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
