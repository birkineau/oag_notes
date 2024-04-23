BEGIN;

--
-- ACTION ALTER TABLE
--
DROP INDEX "user_tag_userId_unique_idx";
CREATE INDEX "user_tag_userId_idx" ON "user_tag" USING btree ("userId");

--
-- MIGRATION VERSION FOR notes
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('notes', '20240414161741972', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240414161741972', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
