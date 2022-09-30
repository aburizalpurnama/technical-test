CREATE TABLE "customers" (
  "id" uuid PRIMARY KEY DEFAULT 'uuid_generate_v4()',
  "name" text NOT NULL
);

CREATE TABLE "products" (
  "id" uuid PRIMARY KEY DEFAULT 'uuid_generate_v4()',
  "name" varchar NOT NULL,
  "price" numeric NOT NULL
);

CREATE TABLE "transactions" (
  "id" uuid PRIMARY KEY DEFAULT 'uuid_generate_v4()',
  "created_at" timestamp DEFAULT 'now()',
  "total" numeric NOT NULL
);

CREATE TABLE "vouchers" (
  "id" uuid PRIMARY KEY DEFAULT 'uuid_generate_v4()',
  "nominal" numeric NOT NULL,
  "expired_date" timestamp DEFAULT (now() - interval '5 month'),
  "redemeed" boolean DEFAULT false,
  "customer_id" uuid,
  "transactions_id" uuid
);

CREATE TABLE "product_transactions" (
  "id" uuid PRIMARY KEY DEFAULT 'uuid_generate_v4()',
  "transactions_id" uuid NOT NULL,
  "products_id" uuid NOT NULL,
  "product_name" varchar NOT NULL,
  "qty" bigint NOT NULL
);

CREATE TABLE "customer_transactions" (
  "id" uuid PRIMARY KEY DEFAULT 'uuid_generate_v4()',
  "transactions_id" uuid NOT NULL,
  "customer_id" uuid NOT NULL,
  "product_name" varchar NOT NULL
);

CREATE INDEX ON "customers" ("name");

CREATE INDEX ON "products" ("name");

CREATE INDEX ON "product_transactions" ("transactions_id");

CREATE INDEX ON "product_transactions" ("products_id");

CREATE INDEX ON "customer_transactions" ("transactions_id");

CREATE INDEX ON "customer_transactions" ("customer_id");

ALTER TABLE "vouchers" ADD FOREIGN KEY ("customer_id") REFERENCES "customers" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "product_transactions" ADD FOREIGN KEY ("transactions_id") REFERENCES "transactions" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "product_transactions" ADD FOREIGN KEY ("products_id") REFERENCES "products" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "customer_transactions" ADD FOREIGN KEY ("transactions_id") REFERENCES "transactions" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "customer_transactions" ADD FOREIGN KEY ("customer_id") REFERENCES "customers" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "transactions" ADD FOREIGN KEY ("id") REFERENCES "vouchers" ("transactions_id") ON DELETE CASCADE ON UPDATE CASCADE;
