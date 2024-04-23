BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "user_tag" DROP CONSTRAINT "user_tag_fk_0";
ALTER TABLE "user_tag" DROP COLUMN "excludes";
ALTER TABLE "user_tag" DROP COLUMN "_userTagsUserId";
--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_tag_link" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "tagId" integer NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_tag_link__userId_tagId__unique_index_idx" ON "user_tag_link" USING btree ("userId", "tagId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_tag_link"
    ADD CONSTRAINT "user_tag_link_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "user_tag_link"
    ADD CONSTRAINT "user_tag_link_fk_1"
    FOREIGN KEY("tagId")
    REFERENCES "user_tag"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR notes
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('notes', '20240411180956131', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240411180956131', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
