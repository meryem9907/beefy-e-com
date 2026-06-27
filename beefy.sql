CREATE TYPE delivery_status AS ENUM (
  'approved',
  'packing',
  'cancelled',
  'delivered',
  'in_delivery'
);

CREATE TYPE "category" AS ENUM (
 'bee_supplements',
'skincare_beauty',
'candles_home',
'food_pantry',
'gift_sets',
'beekeeping_supplies'
);


CREATE TABLE "User" (
  "id" integer PRIMARY KEY,
  "email" varchar(255) NOT NULL UNIQUE,
  "password_hash" varchar(255) NOT NULL
);

CREATE TABLE "Address" (
  "id" integer PRIMARY KEY,
  "neighbourhood" varchar(255) NOT NULL,
  "street" varchar(255) NOT NULL,
  "postal_code" integer(5) NOT NULL,
  "apartment" varchar(255) NOT NULL,
  "city" varchar(255) NOT NULL,
  "country" varchar(255) NOT NULL,
  "district" varchar(255) NOT NULL
);
CREATE TABLE "Customer" (
  "id" integer PRIMARY KEY REFERENCES "User" ("id") ON DELETE CASCADE,
  "shipping_address_id" integer NOT NULL REFERENCES "Address" ("id") ON DELETE CASCADE
);


CREATE TABLE "PickupSchedule" (
  "id" integer PRIMARY KEY,
  "pickup_address_id" integer NOT NULL REFERENCES "Address" ("id") ON DELETE CASCADE,
  "daytime" timestamp NOT NULL
);
CREATE TABLE "LogisticsWorkflow" (
  "id" integer PRIMARY KEY,
  "pickup_schedule_id" integer NOT NULL REFERENCES "PickupSchedule" ("id") ON DELETE CASCADE,
  "shipping_cost" numeric(10,2) NOT NULL,
  "company_name" varchar(255) UNIQUE NOT NULL,
  "contract_link" varchar(500) UNIQUE NOT NULL
);

CREATE TABLE "Vendor" (
  "id" integer PRIMARY KEY REFERENCES "User" ("id") ON DELETE CASCADE,
  "tax_nr" varchar(100) NOT NULL,
  "company_name" varchar(255) NOT NULL,
  "logistics_workflow_id" integer NOT NULL REFERENCES "LogisticsWorkflow" ("id"),
  "phone_nr" varchar(50) NOT NULL,
);


CREATE TABLE "Measurement" (
  "id" integer PRIMARY KEY,
  "weight" numeric(10,2) NOT NULL,
  "volume" numeric(10,2) NOT NULL,
  "height" numeric(10,2) NOT NULL,
  "length" numeric(10,2) NOT NULL
);

CREATE TABLE "Product" (
  "id" integer PRIMARY KEY,
  "short_desc" text NOT NULL,
  "in_stock" boolean NOT NULL,
  "stock_quantity" integer NOT NULL DEFAULT 0,

  "unit_price" float NOT NULL,
  "name" varchar(255) NOT NULL,
  "category" category NOT NULL,
  "issue_date" timestamp NOT NULL,
  "vendor_id" integer NOT NULL REFERENCES "Vendor" ("id") ON DELETE CASCADE,
  "measurement_id" integer REFERENCES "Measurement" ("id") ON DELETE SET NULL
);
CREATE TABLE "ProductPhoto" (
    "product_id" integer NOT NULL REFERENCES "Product" ("id") ON DELETE CASCADE,
    "link" varchar(500) NOT NULL UNIQUE,
      PRIMARY KEY ("link", "product_id")
);
CREATE TABLE "Cart" (
  "id" integer PRIMARY KEY,
  "created_at" timestamp NOT NULL,
  "customer_id" integer UNIQUE NOT NULL REFERENCES "Customer" ("id") ON DELETE CASCADE
);
CREATE TABLE "CartItem" (
  "cart_id" integer NOT NULL REFERENCES "Cart" ("id") ON DELETE CASCADE,
  "product_id" integer NOT NULL REFERENCES "Product" ("id") ON DELETE CASCADE,
    "quantity" integer NOT NULL,

    PRIMARY KEY ("cart_id", "product_id")

);
CREATE TABLE "Wishlist" (
  "id" integer PRIMARY KEY,
  "created_at" timestamp NOT NULL,
  "name" varchar(255) NOT NULL,
  "customer_id" integer NOT NULL REFERENCES "Customer" ("id") ON DELETE CASCADE
);

CREATE TABLE "WishlistProduct" (
  "product_id" integer NOT NULL REFERENCES "Product" ("id") ON DELETE CASCADE,
  "wishlist_id" integer NOT NULL REFERENCES "Wishlist" ("id") ON DELETE CASCADE,
  "added_at" timestamp NOT NULL,
  PRIMARY KEY ("wishlist_id", "product_id")
);






CREATE TABLE "Payment" (
  "reference" integer PRIMARY KEY,
  "provider" varchar(255) NOT NULL
);





CREATE TABLE "Order" (
  "id" integer PRIMARY KEY,
  "customer_id" integer NOT NULL REFERENCES "Customer" ("id"),

"billing_address_id" integer NOT NULL REFERENCES "Address" ("id"),
  "shipped_at" timestamp,
  "delivered_at" timestamp,
  "paid_at" timestamp,
  "tax" numeric(10,2) NOT NULL,
  "created_at" timestamp,
  "shipping_cost" numeric(10,2),
  "subtotal" numeric(10,2),
"total_price" numeric(10,2),
"currency" varchar(3),

  "payment_ref" integer NOT NULL REFERENCES "Payment" ("reference") 
);


CREATE TABLE "OrderItem" (
  "order_id" integer NOT NULL REFERENCES "Order" ("id") ON DELETE CASCADE,
"product_id" integer NOT NULL REFERENCES "Product" ("id"),
"unit_price" numeric(10,2) NOT NULL,
"line_total" numeric(10,2) NOT NULL,
  "quantity" integer NOT NULL,
  "delivery_date" timestamp NOT NULL,
  "delivery_status" delivery_status NOT NULL,
  PRIMARY KEY ("product_id", "order_id")
);