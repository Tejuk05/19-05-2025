CREATE DATABASE login;
use login;
CREATE TABLE IF NOT EXISTS accounts (
    id INT(11) NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

select * from login.accounts;
select * from login.images;

CREATE TABLE images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    description TEXT,
    image_name VARCHAR(100) NOT NULL,
    image_data longblob,
    price DECIMAL(10, 2)
);

drop table recipes;
select * from login.products;

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for the product
    product_name VARCHAR(255) NOT NULL,  -- Name of the product
    product_description TEXT NOT NULL,  -- Detailed description of the product
    price DECIMAL(10, 2) NOT NULL,  -- Price of the product
    image_data LONGBLOB NOT NULL  -- Binary data for the image (no file name)
);
rename table product1 to products;
rename table products to product2;

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_price DECIMAL(10, 2) NOT NULL,
    product_description TEXT NOT NULL,
    product_image_name VARCHAR(255) NOT NULL,
    product_image_data LONGBLOB NOT NULL,
    product_quantity INT NOT NULL
);
select * from login.products;
select * from login.recipes;

CREATE TABLE recipes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    ingredients TEXT NOT NULL,
    instructions TEXT NOT NULL,
    image_name VARCHAR(255) NOT NULL,  -- The name provided by the user for the image
    image_data LONGBLOB NOT NULL       -- The binary data of the image
);

ALTER TABLE recipes
ADD COLUMN submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE recipes
ADD COLUMN status VARCHAR(20) DEFAULT 'pending';

CREATE TABLE handicrafts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_price DECIMAL(10, 2),
    product_description TEXT,
    product_image_name VARCHAR(255),
    product_image_data LONGBLOB,
    product_quantity INT
);

CREATE TABLE textiles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_price DECIMAL(10, 2),
    product_description TEXT,
    product_image_name VARCHAR(255),
    product_image_data LONGBLOB,
    product_quantity INT
);

CREATE TABLE jewellery (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_price DECIMAL(10, 2),
    product_description TEXT,
    product_image_name VARCHAR(255),
    product_image_data LONGBLOB,
    product_quantity INT
);

CREATE TABLE pottery (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_price DECIMAL(10, 2),
    product_description TEXT,
    product_image_name VARCHAR(255),
    product_image_data LONGBLOB,
    product_quantity INT
);

CREATE TABLE natural_oils (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_price DECIMAL(10, 2),
    product_description TEXT,
    product_image_name VARCHAR(255),
    product_image_data LONGBLOB,
    product_quantity INT
);

CREATE TABLE herbal_soaps (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_price DECIMAL(10, 2),
    product_description TEXT,
    product_image_name VARCHAR(255),
    product_image_data LONGBLOB,
    product_quantity INT
);

CREATE TABLE ayurvedic_products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_price DECIMAL(10, 2),
    product_description TEXT,
    product_image_name VARCHAR(255),
    product_image_data LONGBLOB,
    product_quantity INT
);

CREATE TABLE dishes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_price DECIMAL(10, 2),
    product_description TEXT,
    product_image_name VARCHAR(255),
    product_image_data LONGBLOB,
    product_quantity INT
);

-- You might also need a table for 'culture' if you intend to store specific products under that category.
CREATE TABLE culture (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_price DECIMAL(10, 2),
    product_description TEXT,
    product_image_name VARCHAR(255),
    product_image_data LONGBLOB,
    product_quantity INT
);

CREATE TABLE product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_price DECIMAL(10, 2),
    product_description TEXT,
    product_image_name VARCHAR(255),
    product_image_data LONGBLOB,
    product_quantity INT,
    category ENUM('handicrafts', 'textiles', 'jewellery', 'pottery', 'natural_oils', 'herbal_soaps', 'ayurvedic_products') NOT NULL
);
ALTER TABLE product
ADD COLUMN seller_id INT,
ADD CONSTRAINT vsfk_seller
FOREIGN KEY (seller_id) REFERENCES sellers(seller_id);

select* from product;
drop table product;

CREATE TABLE sellers (
    seller_id INT AUTO_INCREMENT PRIMARY KEY,
    business_name VARCHAR(255) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);
select * from login.sellers;

CREATE TABLE admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);
select * from login.admin;


CREATE TABLE admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
select * from admins;

CREATE TABLE cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT(11), -- Changed to INT(11) to match accounts table
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    -- Add other cart details as needed
    FOREIGN KEY (user_id) REFERENCES accounts(id), -- Changed to reference accounts table
    INDEX (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
select * from cart;

CREATE TABLE cart_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL, -- Store price at time of adding to cart
    -- Add other cart item details as needed
    FOREIGN KEY (cart_id) REFERENCES cart(id),
    FOREIGN KEY (product_id) REFERENCES product(id),
    INDEX (cart_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
select * from cart_items;

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    shipping_address TEXT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50) NOT NULL,
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES product(id)
);
select * from orders;

ALTER TABLE orders
ADD COLUMN tracking_number VARCHAR(255) NULL, -- Added tracking_number, made it NULLable initially
ADD COLUMN order_status VARCHAR(50) NOT NULL DEFAULT 'Pending';
ALTER TABLE orders
ADD COLUMN shipping_carrier VARCHAR(255) NULL;

CREATE TABLE recipes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,  -- Foreign key to the 'accounts' table
    title VARCHAR(255) NOT NULL,
    description TEXT,
    ingredients TEXT,       -- Store as comma-separated or JSON
    instructions TEXT,
    image_path VARCHAR(255), -- Path to the stored image
    submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_approved BOOLEAN DEFAULT FALSE, -- Approval status
    FOREIGN KEY (user_id) REFERENCES accounts(id)
);

CREATE TABLE IF NOT EXISTS culture_heritage (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    content_type VARCHAR(50),
    region VARCHAR(100),
    image_name VARCHAR(255),
    image_data MEDIUMBLOB,
    date_added DATETIME DEFAULT CURRENT_TIMESTAMP,
    admin_id INT,
    FOREIGN KEY (admin_id) REFERENCES accounts(id)
);

-- CREATE TABLE skincare (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     name VARCHAR(255) NOT NULL,
--     description TEXT,
--     image_name VARCHAR(255),
--     image_data MEDIUMBLOB,
--     upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );

CREATE TABLE skincare_tips (
    id INT AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

 SELECT * FROM skincare;
 -- If you don't have a 'category' column yet:
INSERT INTO skincare (name, description, image_name) VALUES
('Gentle Cleanser', 'A mild cleanser for daily use.', 'cleanser.jpg'),
('Hydrating Moisturizer', 'Provides essential hydration for all skin types.', 'moisturizer.png');

