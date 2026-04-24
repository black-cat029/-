CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    email VARCHAR(320) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    full_name VARCHAR(200) NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    sku VARCHAR(64) NOT NULL UNIQUE,
    name TEXT NOT NULL,
    description TEXT,
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    weight VARCHAR(32),
    image_url TEXT,
    is_available BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    total_amount NUMERIC(10,2) NOT NULL CHECK (total_amount >= 0),
    delivery_address TEXT,
    delivery_phone VARCHAR(20),
    comment TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0)
);

INSERT INTO customers (email, password_hash, full_name, phone)
VALUES
    ('ivan.petrov@example.com', 'hashed_password_1', 'Иван Петров', '+7 912 345-67-89'),
    ('olga.smirnova@example.com', 'hashed_password_2', 'Ольга Смирнова', '+7 916 123-45-67');

INSERT INTO products (sku, name, description, price, weight, image_url)
VALUES
    ('ICE-001', 'Морозное облако', 'Нежнейший пломбир, который тает во рту, словно облако', 159.00, '90 г', 'https://images.unsplash.com/photo-1563805042-1a3584d0b7f7?w=300&h=300&fit=crop'),
    ('ICE-002', 'Шоколадный экспресс', 'Насыщенный шоколадный вкус с кусочками брауни, как express-билет в счастье', 189.00, '95 г', 'https://images.unsplash.com/photo-1551024709-8f23befc6f87?w=300&h=300&fit=crop'),
    ('ICE-003', 'Клубничный закат', 'Как летний закат в деревне — сладкий, тёплый и незабываемый', 219.00, '100 г', 'https://images.unsplash.com/photo-1551024709-8f23befc6f87?w=300&h=300&fit=crop');

INSERT INTO orders (customer_id, total_amount, delivery_address, delivery_phone, comment)
VALUES
    (1, 348.00, 'ул. Ленина, 12, кв. 45', '+7 912 345-67-89', 'Доставить после 18:00');

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 1, 159.00),
    (1, 2, 1, 189.00);
