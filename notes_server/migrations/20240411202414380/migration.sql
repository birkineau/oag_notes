BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "user" ADD COLUMN "_userTagUsersUserTagId" integer;
ALTER TABLE ONLY "user"
    ADD CONSTRAINT "user_fk_0"
    FOREIGN KEY("_userTagUsersUserTagId")
    REFERENCES "user_tag"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "user_tag" ADD COLUMN "_userTagsUserId" integer;
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
    VALUES ('notes', '20240411202414380', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240411202414380', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
