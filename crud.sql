CREATE TABLE "pizza"(
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(64) NOT NULL CHECK("name" != ''),
    "price" NUMERIC(100, 2) NOT NULL CHECK(
        "price" > 0
        AND "price" < 10000
    ),
    "diameter" SMALLINT NOT NULL CHECK(
        "diameter" >= 15
        AND "diameter" <= 45
    ),
    CONSTRAINT "checkName" CHECK(LENGTH("name") <= 25)
);
--INSERT
INSERT INTO "pizza" ("name", "price", "diameter")
VALUES ('Маргарита', 50.40, 18);

INSERT INTO "pizza" ("name", "price", "diameter")
VALUES ('Карбонара', 81, 28);

INSERT INTO "pizza" ("name", "price", "diameter")
VALUES ('Цезар', 149, 38),
('Пепероні', 116, 32);

--UPDATE
UPDATE "pizza"
SET "price" = 53
WHERE "name" = 'Маргарита';

UPDATE "pizza"
SET "diameter" = 30
WHERE "id" = 4
RETURNING *;

UPDATE "pizza"
SET "price" = 130
WHERE "price" > 100
RETURNING *;

UPDATE "pizza"
SET "diameter" = 22
WHERE "id" > 2
    AND "id" <= 5;

UPDATE "pizza"
SET "name" = '4 сири',
    "price" = 180
WHERE "name" = 'Цезар';

--SELECT

SELECT "id",
    "name"
FROM "pizza"
WHERE "id" = 3;

SELECT "id",
    "name",
    "price"
FROM "pizza"
WHERE "price" < 100;


SELECT "id",
    "name",
    "price"
FROM "pizza"
WHERE "price" != 130;

SELECT 
    "name",
    "price",
    "diameter"
FROM "pizza"
WHERE "name" = 'Пепероні';

SELECT 
    "name",
    "price",
    "diameter"
FROM "pizza"
WHERE "name" = 'Маргарита';

SELECT 
    "name",
    "price",
    "diameter"
FROM "pizza"
WHERE "name" != 'Карбонара';

SELECT 
    "name",
    "price",
    "diameter"
FROM "pizza"
WHERE "price" < 150 AND "diameter" = 22;

SELECT 
    "name",
    "price",
    "diameter"
FROM "pizza"
WHERE "diameter" BETWEEN 25 AND 33;

SELECT 
    "name",
    "price",
    "diameter"
FROM "pizza"
WHERE "diameter" BETWEEN 25 AND 33 OR "price" BETWEEN 100 AND 200;

SELECT 
    "name",
    "price",
    "diameter"
FROM "pizza"
WHERE "diameter" = 22 OR "price" = 180;

--DELETE

DELETE FROM "pizza"
WHERE "id" = 3
RETURNING *;

DELETE FROM "pizza"
WHERE "name" = 'Пепероні'
RETURNING *;

DELETE FROM "pizza"
WHERE "diameter" = 18
RETURNING *;
