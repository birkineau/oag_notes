BEGIN;

--
-- ACTION ALTER TABLE
--
DROP INDEX "password_request__account_id__unique_idx";
CREATE UNIQUE INDEX "password_request__user_id__unique_idx" ON "password_update" USING btree ("userId");
--
-- ACTION ALTER TABLE
--
ALTER TABLE "user" DROP COLUMN "scopes";
--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_tag" (
    "id" serial PRIMARY KEY,
    "name" text NOT NULL,
    "excludes" json,
    "_userTagsUserId" integer
);

-- Indexes
CREATE UNIQUE INDEX "user_tag_value__unique_index_idx" ON "user_tag" USING btree ("name");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_tag"
    ADD CONSTRAINT "user_tag_fk_0"
    FOREIGN KEY("_userTagsUserId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR notes
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('notes', '20240411174005066', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240411174005066', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
