CREATE TABLE IF NOT EXISTS customers (
    id SERIAL PRIMARY KEY,
    email VARCHAR(320) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    full_name VARCHAR(200) NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS products (
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

CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    total_amount NUMERIC(10,2) NOT NULL CHECK (total_amount >= 0),
    delivery_address TEXT,
    delivery_phone VARCHAR(20),
    comment TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0)
);

INSERT INTO products (sku, name, description, price, weight, image_url) VALUES
    ('ICE-001', 'Морозное облако', 'Нежнейший пломбир, который тает во рту, словно облако', 159.00, '90 г', 'https://plus.unsplash.com/premium_photo-1690440686714-c06a56a1511c?w=300&h=300&fit=crop'),
    ('ICE-002', 'Шоколадный экспресс', 'Насыщенный шоколадный вкус с кусочками брауни', 189.00, '95 г', 'https://media.istockphoto.com/id/2228671132/photo/isolated-chocolate-ice-cream-cone-drizzled-with-rich-chocolate.webp?w=300&h=300&fit=crop'),
    ('ICE-003', 'Клубничный закат', 'Как летний закат — сладкий, тёплый и незабываемый', 219.00, '100 г', 'https://plus.unsplash.com/premium_photo-1742103625076-f5e445912d6a?w=300&h=300&fit=crop'),
    ('ICE-004', 'Фисташковый сфинкс', 'Загадочный и изысканный вкус настоящих итальянских фисташек', 249.00, '90 г', 'https://plus.unsplash.com/premium_photo-1663853490433-5ed3ff06f9ea?w=300&h=300&fit=crop'),
    ('ICE-005', 'Тропический бриз', 'Взрыв манго и маракуйи — словно морской бриз', 199.00, '100 г', 'https://plus.unsplash.com/premium_photo-1669905375045-990742dc0ca4?w=300&h=300&fit=crop'),
    ('ICE-006', 'Карамельный взрыв', 'Солёно-сладкая карамель с хрустящим попкорном', 179.00, '95 г', 'https://plus.unsplash.com/premium_photo-1675279010969-e85bfbd402dc?w=300&h=300&fit=crop'),
    ('ICE-007', 'Цитрусовый фреш', 'Освежающий лимонный сорбет, бодрящий как утренний фреш', 169.00, '100 г', 'https://media.istockphoto.com/id/1270107044/photo/lemon-flavored-ice-pops-on-a-glass-plate-with-ice.webp?w=300&h=300&fit=crop'),
    ('ICE-008', 'Мятная свежесть', 'Прохладная мята с шоколадной крошкой', 189.00, '90 г', 'https://media.istockphoto.com/id/1406230986/photo/homemade-green-mint-chocolate-chip-ice-cream.webp?w=300&h=300&fit=crop'),
    ('ICE-009', 'Солёный бриз', 'Идеальный баланс сладкой карамели и морской соли', 229.00, '95 г', 'https://plus.unsplash.com/premium_photo-1776375365800-8c22057b877e?w=300&h=300&fit=crop'),
    ('ICE-010', 'Лавандовый сон', 'Нежный цветочный аромат с мёдом', 239.00, '90 г', 'https://plus.unsplash.com/premium_photo-1691095182210-a1b3c46a31d6?w=300&h=300&fit=crop'),
    ('ICE-011', 'Кокосовая бухта', 'Погружение в райский уголок с кокосовым вкусом', 199.00, '100 г', 'https://plus.unsplash.com/premium_photo-1681488352667-c4d00b903416?w=300&h=300&fit=crop'),
    ('ICE-012', 'Тирамису-мистик', 'Загадочное сочетание кофе, маскарпоне и печенья савоярди', 259.00, '95 g', 'https://media.istockphoto.com/id/843548994/photo/tiramisu-popsicles-ice-pops-with-italian-savoiardi-cookies-and-tiramisu-ingredients-on-rustic.webp?w=300&h=300&fit=crop')
ON CONFLICT (sku) DO NOTHING;

INSERT INTO customers (email, password_hash, full_name, phone) VALUES
    ('test@example.com', 'hashed_password_change_me', 'Тестовый Пользователь', '+79123456789')
ON CONFLICT (email) DO NOTHING;