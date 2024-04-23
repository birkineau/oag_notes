BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "password_update_request" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "password_update" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "validationCodeId" integer NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "password_request__user_id__unique_idx" ON "password_update" USING btree ("userId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "password_update"
    ADD CONSTRAINT "password_update_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "password_update"
    ADD CONSTRAINT "password_update_fk_1"
    FOREIGN KEY("validationCodeId")
    REFERENCES "validation_code"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR notes
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('notes', '20240401185019306', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240401185019306', "timestamp" = now();

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
