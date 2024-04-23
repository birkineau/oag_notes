BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "tag" (
    "id" serial PRIMARY KEY,
    "name" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "tag_name__unique_index_idx" ON "tag" USING btree ("name");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "user" DROP CONSTRAINT "user_fk_0";
ALTER TABLE "user" DROP COLUMN "_userTagUsersUserTagId";
--
-- ACTION DROP TABLE
--
DROP TABLE "user_tag" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_tag" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "tagId" integer NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_tag_unique_index_idx" ON "user_tag" USING btree ("userId", "tagId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_tag"
    ADD CONSTRAINT "user_tag_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "user_tag"
    ADD CONSTRAINT "user_tag_fk_1"
    FOREIGN KEY("tagId")
    REFERENCES "tag"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR notes
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('notes', '20240411211742068', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240411211742068', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
