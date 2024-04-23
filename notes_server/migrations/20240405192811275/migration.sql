BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "fcm_token" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "token" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "fcm_token__user_id__unique_idx" ON "fcm_token" USING btree ("userId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "fcm_token"
    ADD CONSTRAINT "fcm_token_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR notes
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('notes', '20240405192811275', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240405192811275', "timestamp" = now();

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
