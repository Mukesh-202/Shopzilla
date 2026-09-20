
PRAGMA foreign_keys = ON;

-- =========================
-- ADMIN
-- =========================

INSERT OR IGNORE INTO users
(name, email, phone, password, role)
VALUES
(
    'Shopzilla Admin',
    'admin@shopzilla.com',
    '9876543210',
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
    'ADMIN'
);


-- =========================
-- SELLER
-- =========================

INSERT OR IGNORE INTO users
(name, email, phone, password, role)
VALUES
(
    'Fashion Hub',
    'seller@shopzilla.com',
    '9876543211',
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
    'SELLER'
);


-- =========================
-- BUYER
-- =========================

INSERT OR IGNORE INTO users
(name, email, phone, password, role)
VALUES
(
    'Shopzilla Buyer',
    'buyer@shopzilla.com',
    '9876543212',
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
    'BUYER'
);


-- =========================
-- PRODUCTS
-- =========================

INSERT OR IGNORE INTO products
(
    seller_id,
    name,
    category,
    subcategory,
    description,
    price,
    mrp,
    stock,
    sku,
    image_url,
    status
)
SELECT
    id,
    'Premium Cotton Oversized T-Shirt',
    'Men',
    'T-Shirts',
    'Premium cotton oversized casual t-shirt.',
    1299.00,
    1999.00,
    142,
    'SZ-MEN-001',
    'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=600&q=80',
    'APPROVED'
FROM users
WHERE email = 'seller@shopzilla.com';


INSERT OR IGNORE INTO products
(
    seller_id,
    name,
    category,
    subcategory,
    description,
    price,
    mrp,
    stock,
    sku,
    image_url,
    status
)
SELECT
    id,
    'Urban Runner Sneakers',
    'Footwear',
    'Sneakers',
    'Modern lightweight sneakers for everyday style.',
    3199.00,
    4999.00,
    65,
    'SZ-SHOE-001',
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=600&q=80',
    'APPROVED'
FROM users
WHERE email = 'seller@shopzilla.com';


INSERT OR IGNORE INTO products
(
    seller_id,
    name,
    category,
    subcategory,
    description,
    price,
    mrp,
    stock,
    sku,
    image_url,
    status
)
SELECT
    id,
    'Classic Casual Jacket',
    'Men',
    'Jackets',
    'Classic casual jacket suitable for everyday wear.',
    2499.00,
    3999.00,
    39,
    'SZ-JKT-001',
    'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&w=600&q=80',
    'APPROVED'
FROM users
WHERE email = 'seller@shopzilla.com';


INSERT OR IGNORE INTO products
(
    seller_id,
    name,
    category,
    subcategory,
    description,
    price,
    mrp,
    stock,
    sku,
    image_url,
    status
)
SELECT
    id,
    'Floral Summer Dress',
    'Women',
    'Dresses',
    'Lightweight floral summer dress.',
    1799.00,
    2999.00,
    87,
    'SZ-WOM-001',
    'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?auto=format&fit=crop&w=600&q=80',
    'APPROVED'
FROM users
WHERE email = 'seller@shopzilla.com';


INSERT OR IGNORE INTO products
(
    seller_id,
    name,
    category,
    subcategory,
    description,
    price,
    mrp,
    stock,
    sku,
    image_url,
    status
)
SELECT
    id,
    'Graphic Printed Hoodie',
    'Men',
    'Hoodies',
    'Comfortable graphic printed hoodie.',
    1599.00,
    2499.00,
    50,
    'SZ-HOD-001',
    'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&w=600&q=80',
    'PENDING'
FROM users
WHERE email = 'seller@shopzilla.com';


-- =========================
-- SAMPLE REVIEW
-- =========================

INSERT OR IGNORE INTO reviews
(
    user_id,
    product_id,
    rating,
    title,
    comment
)
SELECT
    u.id,
    p.id,
    5,
    'Excellent Product',
    'Good quality and comfortable fit.'
FROM users u
JOIN products p
    ON p.sku = 'SZ-MEN-001'
WHERE u.email = 'buyer@shopzilla.com';


-- =========================
-- SAMPLE CART
-- =========================

INSERT OR IGNORE INTO cart
(
    user_id,
    product_id,
    quantity
)
SELECT
    u.id,
    p.id,
    1
FROM users u
JOIN products p
    ON p.sku = 'SZ-MEN-001'
WHERE u.email = 'buyer@shopzilla.com';
