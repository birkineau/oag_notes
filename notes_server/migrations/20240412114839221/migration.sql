BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "tag" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "tag" (
    "id" serial PRIMARY KEY,
    "type" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "tag_type__unique_index_idx" ON "tag" USING btree ("type");


--
-- MIGRATION VERSION FOR notes
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('notes', '20240412114839221', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240412114839221', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
