BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "user" DROP COLUMN "userTagLink";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "user_tag" DROP COLUMN "userTagLink";

--
-- MIGRATION VERSION FOR notes
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('notes', '20240411200010554', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240411200010554', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
