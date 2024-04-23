BEGIN;

--
-- ACTION ALTER TABLE
--
DROP INDEX "email_validation_code_user_id_unique";
CREATE UNIQUE INDEX "email_validation_code__user_id__unique_idx" ON "email_validation_code" USING btree ("userId");

--
-- MIGRATION VERSION FOR notes
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('notes', '20240401110558871', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240401110558871', "timestamp" = now();

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
