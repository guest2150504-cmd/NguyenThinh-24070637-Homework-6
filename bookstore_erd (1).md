# Online Bookstore — Entity-Relationship Design

**Name:** [YOUR FULL NAME]  
**Student ID:** [YOUR STUDENT ID]  
**Assignment:** Homework 6 — INS3064  
**Date:** 2026-10-18

This text ERD matches `bookstore_db.sql`. The design contains **10 base tables** and **2 calculated views**. All money values use USD. All sample people, books, and publishers are fictional.

## Notation

| Mark | Meaning |
| --- | --- |
| PK | Primary key |
| FK | Foreign key |
| UQ | Unique key |
| AI | Auto-increment surrogate key |
| NN | NOT NULL |
| 1:N | One parent can have many child rows |
| M:N | Many-to-many relationship resolved through a junction table |
| 0..1 / 0..N | Optional one / optional many |

Names and addresses are single values for display and delivery; lists of authors, categories, or order items are represented as separate rows.

## 1. authors

| Attribute | SQL type | Keys / rules |
| --- | --- | --- |
| author_id | INT UNSIGNED | PK, AI, NN |
| full_name | VARCHAR(120) | NN; different authors may share a name |
| biography | TEXT | Nullable |
| nationality | VARCHAR(60) | NN |
| birth_date | DATE | Nullable |

## 2. publishers

| Attribute | SQL type | Keys / rules |
| --- | --- | --- |
| publisher_id | INT UNSIGNED | PK, AI, NN |
| name | VARCHAR(120) | UQ, NN |
| address | VARCHAR(255) | NN |
| website | VARCHAR(255) | Nullable |

## 3. categories

| Attribute | SQL type | Keys / rules |
| --- | --- | --- |
| category_id | INT UNSIGNED | PK, AI, NN |
| name | VARCHAR(80) | UQ, NN |
| description | TEXT | Nullable |
| parent_category_id | INT UNSIGNED | FK → categories.category_id; nullable, default NULL |

The sample category **Programming** is a child of **Technology**. Root categories have a NULL parent. The sample hierarchy has no cycles; the self-referencing FK checks that a referenced parent exists.

## 4. books

| Attribute | SQL type | Keys / rules |
| --- | --- | --- |
| book_id | INT UNSIGNED | PK, AI, NN |
| title | VARCHAR(200) | NN |
| isbn | CHAR(13) | UQ, NN; exactly 13 digits |
| description | TEXT | Nullable |
| price | DECIMAL(10,2) | NN; greater than 0 |
| stock | INT | NN, default 0; at least 0 |
| publication_date | DATE | NN |
| publisher_id | INT UNSIGNED | FK → publishers.publisher_id, NN |

The SQL checks ISBN format; the demonstration ISBNs also have valid ISBN-13 check digits. These fictional titles are not claims about actual ISBN assignments.

## 5. book_authors

| Attribute | SQL type | Keys / rules |
| --- | --- | --- |
| book_id | INT UNSIGNED | PK part 1, FK → books.book_id, NN |
| author_id | INT UNSIGNED | PK part 2, FK → authors.author_id, NN |

**Composite PK:** `(book_id, author_id)`. A book/author pair can occur only once. This junction resolves **books M:N authors**.

## 6. book_categories

| Attribute | SQL type | Keys / rules |
| --- | --- | --- |
| book_id | INT UNSIGNED | PK part 1, FK → books.book_id, NN |
| category_id | INT UNSIGNED | PK part 2, FK → categories.category_id, NN |

**Composite PK:** `(book_id, category_id)`. A book/category pair can occur only once. This junction resolves **books M:N categories**.

## 7. customers

| Attribute | SQL type | Keys / rules |
| --- | --- | --- |
| customer_id | INT UNSIGNED | PK, AI, NN |
| full_name | VARCHAR(120) | NN |
| email | VARCHAR(150) | UQ, NN |
| password_hash | VARCHAR(255) | NN; salted bcrypt in the sample data |
| phone | VARCHAR(25) | Nullable |
| address | VARCHAR(255) | NN; current default address |
| created_at | DATETIME | NN, default CURRENT_TIMESTAMP |

## 8. orders

| Attribute | SQL type | Keys / rules |
| --- | --- | --- |
| order_id | INT UNSIGNED | PK, AI, NN |
| customer_id | INT UNSIGNED | FK → customers.customer_id, NN |
| order_date | DATETIME | NN, default CURRENT_TIMESTAMP |
| status | ENUM('pending', 'paid', 'shipped', 'completed', 'cancelled') | NN, default 'pending' |
| shipping_address | VARCHAR(255) | NN; delivery address recorded for this order |

The requested **total** is calculated as `order_summary.total`. It is not an independently stored column in the normalized base table.

## 9. order_items

| Attribute | SQL type | Keys / rules |
| --- | --- | --- |
| order_id | INT UNSIGNED | PK part 1, FK → orders.order_id, NN |
| book_id | INT UNSIGNED | PK part 2, FK → books.book_id, NN |
| quantity | INT | NN, default 1; greater than 0 |
| unit_price | DECIMAL(10,2) | NN; greater than 0; price agreed for this sale |

**Composite PK:** `(order_id, book_id)`. Multiple copies of a book use `quantity` instead of duplicate lines. The requested **subtotal** is calculated as `order_item_details.subtotal`.

## 10. reviews

| Attribute | SQL type | Keys / rules |
| --- | --- | --- |
| review_id | INT UNSIGNED | PK, AI, NN |
| customer_id | INT UNSIGNED | FK → customers.customer_id, NN |
| book_id | INT UNSIGNED | FK → books.book_id, NN |
| rating | TINYINT | NN; from 1 through 5 |
| comment_text | TEXT | Nullable |
| review_date | DATETIME | NN, default CURRENT_TIMESTAMP |

**Composite UQ:** `(customer_id, book_id)`. Each customer can review a particular book once. All ten sample reviews follow completed purchases. Purchase verification is a property of this sample data, rather than an additional schema constraint.

## Relationships and cardinality

Each child row below references exactly one parent unless the optional parent-category relationship is specified. Parent rows may have zero or many child rows; a newly created order may temporarily have no items.

| Parent → child | Cardinality | FK in child | ON DELETE | ON UPDATE |
| --- | --- | --- | --- | --- |
| publishers → books | 1:N | books.publisher_id | RESTRICT | CASCADE |
| categories → categories | 1:N; each child has 0..1 parent | categories.parent_category_id | SET NULL | CASCADE |
| books → book_authors | 1:N | book_authors.book_id | CASCADE | CASCADE |
| authors → book_authors | 1:N | book_authors.author_id | CASCADE | CASCADE |
| books → book_categories | 1:N | book_categories.book_id | CASCADE | CASCADE |
| categories → book_categories | 1:N | book_categories.category_id | CASCADE | CASCADE |
| customers → orders | 1:N | orders.customer_id | RESTRICT | CASCADE |
| orders → order_items | 1:N | order_items.order_id | CASCADE | CASCADE |
| books → order_items | 1:N | order_items.book_id | RESTRICT | CASCADE |
| customers → reviews | 1:N | reviews.customer_id | CASCADE | CASCADE |
| books → reviews | 1:N | reviews.book_id | CASCADE | CASCADE |

The conceptual M:N relationships are:

| Entity pair | Resolving table | Unique pair |
| --- | --- | --- |
| books M:N authors | book_authors | (book_id, author_id) |
| books M:N categories | book_categories | (book_id, category_id) |
| orders M:N books | order_items | (order_id, book_id) |

## Calculated views

| View | Columns | Calculation |
| --- | --- | --- |
| order_item_details | order_id, book_id, quantity, unit_price, subtotal | subtotal = quantity × unit_price |
| order_summary | order_id, customer_id, order_date, status, shipping_address, total | total = SUM(quantity × unit_price); 0.00 for an empty order |

These views provide the total and subtotal requested in the brief while keeping the ten underlying tables free from redundant calculated amounts. Totals are merchandise totals; this assignment does not add shipping fees, tax, or discounts as separate charges. Discounts can be reflected in the agreed sale-time `unit_price`.

## Why the design satisfies 3NF

1. **1NF:** Every field holds one value. Books with multiple authors or categories use junction rows. An order's books are separate `order_items` rows.
2. **2NF:** Junction tables contain only their composite keys. Both `quantity` and the historical `unit_price` depend on the complete `(order_id, book_id)` key. Other tables use surrogate primary keys and have no partial-key dependencies.
3. **3NF:** Book rows contain a publisher ID rather than publisher details. Orders reference customers without duplicating account details. Author and category details are stored once. Calculated monetary amounts are provided by views.

`customers.address` and `orders.shipping_address` describe different facts: a customer's current default address and the address chosen for a particular order. In the sample, customer 1 uses a different address for order 5. Likewise, order 1 records a sale price of **23.90** for book 1 while its current catalog price is **24.90**. These snapshots preserve transaction history.

## Sample-data coverage

| Base table | Required minimum | Included |
| --- | ---: | ---: |
| authors | 6 | 6 |
| publishers | 4 | 4 |
| categories | 5 | 5 |
| books | 8 | 8 |
| book_authors | Linked relationships | 11 |
| book_categories | Linked relationships | 12 |
| customers | 5 | 5 |
| orders | 6 | 6 |
| order_items | 12 | 14 |
| reviews | 10 | 10 |

Source requirements: [Homework 6 — Online Bookstore](https://hieutachi.github.io/INS3064-Student-Site/homework/session-06/homework.html).
