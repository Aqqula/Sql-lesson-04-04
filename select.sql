SELECT *
FROM "users";
SELECT "id",
    "firstName",
    "lastName",
    "isMale"
FROM "users";
-- SORTED
SELECT "id",
    "firstName",
    "lastName",
    "isMale"
FROM "users"
WHERE "isMale" = FALSE;
SELECT "id",
    "firstName",
    "lastName",
    "isMale"
FROM "users"
WHERE "id" %5 = 0
    AND "isMale" = FALSE;
SELECT "id",
    "firstName",
    "lastName",
    "isMale"
FROM "users"
WHERE "id" %2 = 1
    AND "isMale" = TRUE;
SELECT "id",
    "firstName",
    "lastName",
    "isMale"
FROM "users"
WHERE "id" >= 100
    AND "id" < 105;
SELECT "id",
    "firstName",
    "lastName",
    "isMale",
    "height"
FROM "users"
WHERE "height" BETWEEN 1.80 AND 1.95
    AND "isMale" = TRUE;
SELECT "id",
    "firstName",
    "lastName",
    "isMale",
    "height"
FROM "users"
WHERE "height" >= 1.80
    AND "height" <= 1.95
    AND "isMale" = TRUE;
-- витягти усіх молодше 28 років
SELECT "id",
    "firstName",
    "lastName",
    "isMale",
    extract(
        "years"
        FROM age("birthday")
    ) AS "age",
    extract(
        "years"
        FROM "birthday"
    ) AS "age of bday"
FROM "users"
WHERE age("birthday") < make_interval(28);
--витягти усіх жінок від 25 до 29 включно
SELECT "id",
    "firstName",
    "lastName",
    "isMale",
    extract(
        "years"
        FROM age("birthday")
    ) AS "age",
    extract(
        "years"
        FROM "birthday"
    ) AS "age of bday"
FROM "users"
WHERE extract(
        "years"
        FROM age("birthday")
    ) BETWEEN 25 AND 29
    AND "isMale" = FALSE;
--витягти усіх, хто народився 1998 році
SELECT "id",
    "firstName",
    "lastName",
    "isMale",
    extract(
        "years"
        FROM age("birthday")
    ) AS "age",
    extract(
        "years"
        FROM "birthday"
    ) AS "age of bday"
FROM "users"
WHERE extract(
        "years"
        FROM "birthday"
    ) = 1998;
--витягти усі, хто народився 13 числа
SELECT "id",
    "firstName",
    "lastName",
    "isMale",
    extract(
        "years"
        FROM age("birthday")
    ) AS "age",
    extract(
        "years"
        FROM "birthday"
    ) AS "age of bday",
    "birthday"
FROM "users"
WHERE extract(
        "days"
        FROM "birthday"
    ) = 13;
--витягти усіх чоловіків, які народилися влітку
SELECT "id",
    "firstName",
    "lastName",
    "isMale",
    "birthday"
FROM "users"
WHERE extract(
        "months"
        FROM "birthday"
    ) IN (05, 06, 07)
    AND "isMale" = TRUE;
--витягти усіх чоловіків віком старше 45 зі зростом менше 1.75
SELECT "id",
    "firstName",
    "lastName",
    "isMale",
    extract(
        "years"
        FROM age("birthday")
    ) AS "age",
    "height"
FROM "users"
WHERE extract(
        "years"
        FROM age("birthday")
    ) > 45
    AND "isMale" = TRUE
    AND "height" < 1.75;
SELECT "id",
    "firstName",
    "email",
    "isMale",
    extract(
        "years"
        FROM age("birthday")
    ) AS "age",
    "height"
FROM "users"
WHERE extract(
        "years"
        FROM age("birthday")
    ) > 35
    AND "isMale" = TRUE
    AND "height" > 1.65
LIMIT 5 OFFSET 2;
--example
SELECT concat("firstName", ' ', "lastName") AS "fullName"
FROM "users"
WHERE length(concat("firstName", ' ', "lastName")) BETWEEN 15 AND 20;
SELECT "firstName" || ' ' || "lastName" AS "fullName"
FROM "users"
WHERE length("firstName" || ' ' || "lastName") BETWEEN 15 AND 20;

--EXAMPLE
SELECT *
FROM (
        SELECT concat("firstName", ' ', "lastName") AS "fullName",
            length(concat("firstName", ' ', "lastName")) AS "length"
        FROM "users"
    ) AS "fn_length"
WHERE "fn_length"."length" = 18;