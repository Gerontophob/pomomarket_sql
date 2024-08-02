-- CreateEnum
CREATE TYPE "enum_products_approved_for_sale" AS ENUM ('pending', 'approved', 'denied');

-- CreateEnum
CREATE TYPE "enum_products_category" AS ENUM ('legumes', 'fruits', 'viandes', 'produits_laitiers', 'boulangerie');

-- CreateEnum
CREATE TYPE "enum_users_role" AS ENUM ('admin', 'user');

-- CreateTable
CREATE TABLE "media" (
    "id" SERIAL NOT NULL,
    "updated_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "url" VARCHAR,
    "filename" VARCHAR,
    "mime_type" VARCHAR,
    "filesize" DECIMAL,
    "width" DECIMAL,
    "height" DECIMAL,
    "focal_x" DECIMAL,
    "focal_y" DECIMAL,
    "sizes_thumbnail_url" VARCHAR,
    "sizes_thumbnail_width" DECIMAL,
    "sizes_thumbnail_height" DECIMAL,
    "sizes_thumbnail_mime_type" VARCHAR,
    "sizes_thumbnail_filesize" DECIMAL,
    "sizes_thumbnail_filename" VARCHAR,
    "sizes_card_url" VARCHAR,
    "sizes_card_width" DECIMAL,
    "sizes_card_height" DECIMAL,
    "sizes_card_mime_type" VARCHAR,
    "sizes_card_filesize" DECIMAL,
    "sizes_card_filename" VARCHAR,
    "sizes_tablet_url" VARCHAR,
    "sizes_tablet_width" DECIMAL,
    "sizes_tablet_height" DECIMAL,
    "sizes_tablet_mime_type" VARCHAR,
    "sizes_tablet_filesize" DECIMAL,
    "sizes_tablet_filename" VARCHAR,

    CONSTRAINT "media_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "media_rels" (
    "id" SERIAL NOT NULL,
    "order" INTEGER,
    "parent_id" INTEGER NOT NULL,
    "path" VARCHAR NOT NULL,
    "users_id" INTEGER,

    CONSTRAINT "media_rels_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "orders" (
    "id" SERIAL NOT NULL,
    "_ispaid" BOOLEAN NOT NULL,
    "updated_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "orders_rels" (
    "id" SERIAL NOT NULL,
    "order" INTEGER,
    "parent_id" INTEGER NOT NULL,
    "path" VARCHAR NOT NULL,
    "users_id" INTEGER,
    "products_id" INTEGER,

    CONSTRAINT "orders_rels_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payload_migrations" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR,
    "batch" DECIMAL,
    "updated_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "payload_migrations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payload_preferences" (
    "id" SERIAL NOT NULL,
    "key" VARCHAR,
    "value" JSONB,
    "updated_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "payload_preferences_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payload_preferences_rels" (
    "id" SERIAL NOT NULL,
    "order" INTEGER,
    "parent_id" INTEGER NOT NULL,
    "path" VARCHAR NOT NULL,
    "users_id" INTEGER,

    CONSTRAINT "payload_preferences_rels_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "products" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR NOT NULL,
    "description" VARCHAR,
    "price" DECIMAL NOT NULL,
    "category" "enum_products_category" NOT NULL,
    "approvedForSale" "enum_products_approved_for_sale",
    "price_id" VARCHAR,
    "stripe_id" VARCHAR,
    "updated_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "products_images" (
    "_order" INTEGER NOT NULL,
    "_parent_id" INTEGER NOT NULL,
    "id" VARCHAR NOT NULL,

    CONSTRAINT "products_images_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "products_rels" (
    "id" SERIAL NOT NULL,
    "order" INTEGER,
    "parent_id" INTEGER NOT NULL,
    "path" VARCHAR NOT NULL,
    "users_id" INTEGER,
    "media_id" INTEGER,

    CONSTRAINT "products_rels_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "role" "enum_users_role" NOT NULL,
    "updated_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" VARCHAR NOT NULL,
    "reset_password_token" VARCHAR,
    "reset_password_expiration" TIMESTAMPTZ(3),
    "salt" VARCHAR,
    "hash" VARCHAR,
    "_verified" BOOLEAN,
    "_verificationtoken" VARCHAR,
    "login_attempts" DECIMAL,
    "lock_until" TIMESTAMPTZ(3),

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users_rels" (
    "id" SERIAL NOT NULL,
    "order" INTEGER,
    "parent_id" INTEGER NOT NULL,
    "path" VARCHAR NOT NULL,
    "products_id" INTEGER,

    CONSTRAINT "users_rels_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "media_filename_idx" ON "media"("filename");

-- CreateIndex
CREATE INDEX "media_created_at_idx" ON "media"("created_at");

-- CreateIndex
CREATE INDEX "media_sizes_card_sizes_card_filename_idx" ON "media"("sizes_card_filename");

-- CreateIndex
CREATE INDEX "media_sizes_tablet_sizes_tablet_filename_idx" ON "media"("sizes_tablet_filename");

-- CreateIndex
CREATE INDEX "media_sizes_thumbnail_sizes_thumbnail_filename_idx" ON "media"("sizes_thumbnail_filename");

-- CreateIndex
CREATE INDEX "media_rels_order_idx" ON "media_rels"("order");

-- CreateIndex
CREATE INDEX "media_rels_parent_idx" ON "media_rels"("parent_id");

-- CreateIndex
CREATE INDEX "media_rels_path_idx" ON "media_rels"("path");

-- CreateIndex
CREATE INDEX "orders_created_at_idx" ON "orders"("created_at");

-- CreateIndex
CREATE INDEX "orders_rels_order_idx" ON "orders_rels"("order");

-- CreateIndex
CREATE INDEX "orders_rels_parent_idx" ON "orders_rels"("parent_id");

-- CreateIndex
CREATE INDEX "orders_rels_path_idx" ON "orders_rels"("path");

-- CreateIndex
CREATE INDEX "payload_migrations_created_at_idx" ON "payload_migrations"("created_at");

-- CreateIndex
CREATE INDEX "payload_preferences_created_at_idx" ON "payload_preferences"("created_at");

-- CreateIndex
CREATE INDEX "payload_preferences_key_idx" ON "payload_preferences"("key");

-- CreateIndex
CREATE INDEX "payload_preferences_rels_order_idx" ON "payload_preferences_rels"("order");

-- CreateIndex
CREATE INDEX "payload_preferences_rels_parent_idx" ON "payload_preferences_rels"("parent_id");

-- CreateIndex
CREATE INDEX "payload_preferences_rels_path_idx" ON "payload_preferences_rels"("path");

-- CreateIndex
CREATE INDEX "products_created_at_idx" ON "products"("created_at");

-- CreateIndex
CREATE INDEX "products_images_order_idx" ON "products_images"("_order");

-- CreateIndex
CREATE INDEX "products_images_parent_id_idx" ON "products_images"("_parent_id");

-- CreateIndex
CREATE INDEX "products_rels_order_idx" ON "products_rels"("order");

-- CreateIndex
CREATE INDEX "products_rels_parent_idx" ON "products_rels"("parent_id");

-- CreateIndex
CREATE INDEX "products_rels_path_idx" ON "products_rels"("path");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_idx" ON "users"("email");

-- CreateIndex
CREATE INDEX "users_created_at_idx" ON "users"("created_at");

-- CreateIndex
CREATE INDEX "users_rels_order_idx" ON "users_rels"("order");

-- CreateIndex
CREATE INDEX "users_rels_parent_idx" ON "users_rels"("parent_id");

-- CreateIndex
CREATE INDEX "users_rels_path_idx" ON "users_rels"("path");

-- AddForeignKey
ALTER TABLE "media_rels" ADD CONSTRAINT "media_rels_parent_fk" FOREIGN KEY ("parent_id") REFERENCES "media"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "media_rels" ADD CONSTRAINT "media_rels_users_fk" FOREIGN KEY ("users_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "orders_rels" ADD CONSTRAINT "orders_rels_parent_fk" FOREIGN KEY ("parent_id") REFERENCES "orders"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "orders_rels" ADD CONSTRAINT "orders_rels_products_fk" FOREIGN KEY ("products_id") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "orders_rels" ADD CONSTRAINT "orders_rels_users_fk" FOREIGN KEY ("users_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "payload_preferences_rels" ADD CONSTRAINT "payload_preferences_rels_parent_fk" FOREIGN KEY ("parent_id") REFERENCES "payload_preferences"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "payload_preferences_rels" ADD CONSTRAINT "payload_preferences_rels_users_fk" FOREIGN KEY ("users_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "products_images" ADD CONSTRAINT "products_images_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "products_rels" ADD CONSTRAINT "products_rels_media_fk" FOREIGN KEY ("media_id") REFERENCES "media"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "products_rels" ADD CONSTRAINT "products_rels_parent_fk" FOREIGN KEY ("parent_id") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "products_rels" ADD CONSTRAINT "products_rels_users_fk" FOREIGN KEY ("users_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "users_rels" ADD CONSTRAINT "users_rels_parent_fk" FOREIGN KEY ("parent_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "users_rels" ADD CONSTRAINT "users_rels_products_fk" FOREIGN KEY ("products_id") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE NO ACTION;
