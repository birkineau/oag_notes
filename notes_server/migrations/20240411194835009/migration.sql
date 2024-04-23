BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "user" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user" (
    "id" serial PRIMARY KEY,
    "uid" text NOT NULL,
    "email" text NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "userTagLink" json NOT NULL,
    "blocked" boolean NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "user_tag" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_tag" (
    "id" serial PRIMARY KEY,
    "name" text NOT NULL,
    "userTagLink" json NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_tag_value__unique_index_idx" ON "user_tag" USING btree ("name");


--
-- MIGRATION VERSION FOR notes
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('notes', '20240411194835009', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240411194835009', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
