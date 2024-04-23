BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "validation_code" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "passcode" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "value" text NOT NULL,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "passcode_user_id_unique_idx" ON "passcode" USING btree ("userId");

--
-- ACTION DROP TABLE
--
DROP TABLE "password_update" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "password_update" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "passcodeId" integer NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "password_update_user_id_unique_idx" ON "password_update" USING btree ("userId");

--
-- ACTION ALTER TABLE
--
DROP INDEX "tag_type__unique_index_idx";
CREATE UNIQUE INDEX "tag_type_unique_index_idx" ON "tag" USING btree ("type");
--
-- ACTION ALTER TABLE
--
DROP INDEX "user_tag_unique_index_idx";
CREATE UNIQUE INDEX "user_tag_userId_unique_idx" ON "user_tag" USING btree ("userId");
CREATE UNIQUE INDEX "user_tag_userId_tagId_unique_idx" ON "user_tag" USING btree ("userId", "tagId");
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "passcode"
    ADD CONSTRAINT "passcode_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "password_update"
    ADD CONSTRAINT "password_update_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "password_update"
    ADD CONSTRAINT "password_update_fk_1"
    FOREIGN KEY("passcodeId")
    REFERENCES "passcode"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR notes
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('notes', '20240412180941104', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240412180941104', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
