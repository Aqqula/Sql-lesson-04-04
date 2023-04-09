DROP TABLE IF EXISTS "messages";
DROP TABLE IF EXISTS "users_to_group";
DROP TABLE IF EXISTS "MariiaProducts_to_orders";
DROP TABLE IF EXISTS "orders";
DROP TABLE IF EXISTS "MariiaProducts";
DROP TABLE IF EXISTS "group";
DROP TABLE IF EXISTS "users";
CREATE TABLE "users"(
    "id" SERIAL PRIMARY KEY,
    "firstName" VARCHAR(64) NOT NULL CHECK("firstName" != ''),
    "lastName" VARCHAR(128) NOT NULL CHECK("lastName" != ''),
    "email" VARCHAR(256) NOT NULL CHECK("email" != '') UNIQUE,
    "isMale" BOOLEAN NOT NULL,
    "birthday" DATE NOT NULL CHECK("birthday" < CURRENT_DATE),
    "height" NUMERIC(3, 2) NOT NULL CHECK(
        "height" > 1.10
        AND "height" < 2.55
    )
);
INSERT INTO "users" (
        "firstName",
        "lastName",
        "email",
        "isMale",
        "birthday",
        "height"
    )
VALUES (
        'Brad',
        'Pitt',
        'pitt@gmail.com',
        TRUE,
        '1963-12-18',
        1.87
    ),
    (
        'Tom',
        'Rot',
        'rot@gmail.com',
        TRUE,
        '1965-12-18',
        1.85
    ),
    (
        'Tom2',
        'Rot2',
        'rot2@gmail.com',
        TRUE,
        '1962-12-18',
        1.82
    );
ALTER TABLE "users"
ADD CONSTRAINT "checkEmailLength" CHECK (LENGTH("email") >= 7)
ALTER TABLE "users"
ADD CONSTRAINT "checkName" UNIQUE ("firstName", "lastName")
ALTER TABLE "users"
ADD CONSTRAINT "checkBirthday" CHECK ("birthday" > '1900-12-31') DROP TABLE IF EXISTS "orders";
CREATE TABLE "MariiaProducts"(
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(256) NOT NULL UNIQUE CHECK("name" != ''),
    "price" NUMERIC(1000, 2) NOT NULL CHECK(
        "price" > 0
        AND "price" < 1000000
    ),
    "currency" VARCHAR(3) NOT NULL CHECK("currency" != '') DEFAULT 'UAH',
    "count" SMALLINT NOT NULL CHECK(
        "count" >= 0
        AND "count" < 1000
    ) DEFAULT 10,
    "dateOfManufactur" TIMESTAMP CHECK("dateOfManufactur" < CURRENT_TIMESTAMP),
    "expiry" DATE
);
INSERT INTO "MariiaProducts" ("name", "price")
VALUES ('Milk', '24.90'),
    ('Feed', '16.90'),
    ('Flour', '50.40');
CREATE TABLE "orders"(
    "id" SERIAL PRIMARY KEY,
    "userId" INTEGER REFERENCES "users"("id"),
    "createdAt" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "orders"("userId")
VALUES (1),
    (2),
    (2),
    (3);
CREATE TABLE "MariiaProducts_to_orders"(
    "productId" INT REFERENCES "MariiaProducts"("id"),
    "orderId" INT REFERENCES "orders"("id"),
    "quantity" SMALLINT NOT NULL CHECK("quantity" > 0),
    PRIMARY KEY("productId", "orderId")
);
INSERT INTO "MariiaProducts_to_orders"
VALUES (1, 1, 2),
    (2, 2, 3);
CREATE TABLE "group"(
    "id" SMALLSERIAL PRIMARY KEY,
    "title" VARCHAR(256) NOT NULL CHECK("title" != ''),
    "ownerId" INT REFERENCES "users"("id"),
    "createdAt" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "group"("title", "ownerId")
VALUES ('db', 1),
    ('back', 2);
CREATE TABLE "users_to_group"(
    "groupId" SMALLINT REFERENCES "group"("id"),
    "userId" INT REFERENCES "users"("id"),
    "createdAt" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("groupId", "userId")
);
INSERT INTO "users_to_group"
VALUES (1, 1),
    (1, 2),
    (1, 3),
    (2, 1);
CREATE TABLE "messages"(
    "id" SERIAL PRIMARY KEY,
    "body" VARCHAR(4096) CHECK("body" != '') NOT NULL,
    "isRead" BOOLEAN NOT NULL DEFAULT FALSE,
    "userId" INTEGER,
    "groupId" SMALLINT,
    "createdAt" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "checkBodyLength" CHECK(LENGTH("body") >= 2),
    FOREIGN KEY ("groupId", "userId") REFERENCES "users_to_group" ("groupId", "userId")
);
INSERT INTO "messages"("userId", "body")
VALUES (1, 'hi!'),
    (2, 'hi!'),
    (3, 'hi!'),
    (2, ')))');