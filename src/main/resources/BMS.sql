-- =============================================
-- BookMyShow – Sample Seed Data
-- =============================================

-- =============================================
-- 1. DATABASE
-- =============================================

CREATE DATABASE IF NOT EXISTS bms;
USE bms;


-- =============================================
-- 2. CREATE TABLES
-- =============================================

CREATE TABLE IF NOT EXISTS cities (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    state VARCHAR(255),
    PRIMARY KEY (id),
    UNIQUE KEY uk_city_name (name)
);


CREATE TABLE IF NOT EXISTS users (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(255),
    created_at DATETIME(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_user_email (email)
);


CREATE TABLE IF NOT EXISTS movies (
    id BIGINT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    genre VARCHAR(255),
    language VARCHAR(255),
    duration_minutes INT,
    rating DOUBLE,
    release_date DATE,
    poster_url VARCHAR(255),
    PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS theaters (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    city_id BIGINT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_theater_city
        FOREIGN KEY (city_id) REFERENCES cities(id)
);


CREATE TABLE IF NOT EXISTS screens (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    total_seats INT,
    theater_id BIGINT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_screen_theater
        FOREIGN KEY (theater_id) REFERENCES theaters(id)
);


CREATE TABLE IF NOT EXISTS seats (
    id BIGINT NOT NULL AUTO_INCREMENT,
    seat_number VARCHAR(255) NOT NULL,
    seat_row VARCHAR(255),
    seat_col INT,
    seat_type VARCHAR(255),
    screen_id BIGINT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_seat_screen
        FOREIGN KEY (screen_id) REFERENCES screens(id)
);


CREATE TABLE IF NOT EXISTS shows (
    id BIGINT NOT NULL AUTO_INCREMENT,
    movie_id BIGINT NOT NULL,
    screen_id BIGINT NOT NULL,
    show_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME,
    ticket_price DOUBLE,
    PRIMARY KEY (id),
    CONSTRAINT fk_show_movie
        FOREIGN KEY (movie_id) REFERENCES movies(id),
    CONSTRAINT fk_show_screen
        FOREIGN KEY (screen_id) REFERENCES screens(id)
);


CREATE TABLE IF NOT EXISTS bookings (
    id BIGINT NOT NULL AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    show_id BIGINT NOT NULL,
    total_price DOUBLE,
    status VARCHAR(255),
    booked_at DATETIME(6),
    PRIMARY KEY (id),
    CONSTRAINT fk_booking_user
        FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_booking_show
        FOREIGN KEY (show_id) REFERENCES shows(id)
);


CREATE TABLE IF NOT EXISTS booking_seats (
    booking_id BIGINT NOT NULL,
    seat_id BIGINT NOT NULL,
    PRIMARY KEY (booking_id, seat_id),
    CONSTRAINT fk_booking_seats_booking
        FOREIGN KEY (booking_id) REFERENCES bookings(id),
    CONSTRAINT fk_booking_seats_seat
        FOREIGN KEY (seat_id) REFERENCES seats(id)
);


-- =============================================
-- 3. CITIES
-- =============================================

INSERT INTO cities (name, state) VALUES
('Mumbai', 'Maharashtra'),
('Delhi', 'Delhi'),
('Bangalore', 'Karnataka'),
('Hyderabad', 'Telangana'),
('Chennai', 'Tamil Nadu'),
('Kolkata', 'West Bengal');


-- =============================================
-- 4. USERS
-- =============================================

INSERT INTO users
(name, email, password, phone, created_at)
VALUES
('Ashis Saha', 'ashis@example.com', 'pass123', '7449336118', NOW()),
('Priya Patel', 'priya@example.com', 'pass123', '9876543211', NOW()),
('Amit Kumar', 'amit@example.com', 'pass123', '9876543212', NOW()),
('Sneha Reddy', 'sneha@example.com', 'pass123', '9876543213', NOW());


-- =============================================
-- 5. MOVIES
-- =============================================

INSERT INTO movies
(title, description, genre, language, duration_minutes, rating, release_date, poster_url)
VALUES
(
    'Pushpa 2',
    'The rule of Pushpa Raj continues',
    'Action',
    'Telugu',
    150,
    8.2,
    '2025-12-05',
    'https://www.cinejosh.com/newsimg/newsmainimg/allu-arjun-to-make-grand-entry-for-pushpa-2-the-rule-trailer-launch_b_1611240530.jpg'
),
(
    'Jawan',
    'A prison warden recruits inmates to commit acts of terror',
    'Action',
    'Hindi',
    160,
    7.9,
    '2025-09-07',
    'https://upload.wikimedia.org/wikipedia/en/3/39/Jawan_film_poster.jpg'
),
(
    'Animal',
    'A son undergoes a transformation when his father is in danger',
    'Drama',
    'Hindi',
    180,
    7.5,
    '2025-12-01',
    'https://upload.wikimedia.org/wikipedia/en/thumb/9/90/Animal_%282023_film%29_poster.jpg/250px-Animal_%282023_film%29_poster.jpg'
),
(
    'Leo',
    'A mild-mannered cafe owner hides a violent past',
    'Thriller',
    'Tamil',
    155,
    7.0,
    '2025-10-19',
    'https://upload.wikimedia.org/wikipedia/en/7/75/Leo_%282023_Indian_film%29.jpg'
),
(
    'Dunki',
    'The story of illegal immigration through donkey flight',
    'Comedy',
    'Hindi',
    140,
    6.8,
    '2025-12-21',
    'https://upload.wikimedia.org/wikipedia/en/thumb/4/4f/Dunki_poster.jpg/250px-Dunki_poster.jpg'
);


-- =============================================
-- 6. THEATERS
-- =============================================

INSERT INTO theaters (name, address, city_id) VALUES
('PVR Phoenix', 'Lower Parel, Mumbai', 1),
('INOX Nariman Point', 'Nariman Point, Mumbai', 1),
('PVR Select City', 'Saket, New Delhi', 2),
('GOLD Cinema', 'Rajiv Chowk, New Delhi', 2),
('INOX Mantri Mall', 'Malleshwaram, Bangalore', 3),
('AMB Cinemas', 'Gachibowli, Hyderabad', 4),
('SPI Palazzo', 'Vadapalani, Chennai', 5),
('INOX South City', 'South City Mall, Kolkata', 6),
('PVR Mani Square', 'Mani Square Mall, Kolkata', 6),
('Cinepolis Acropolis', 'Acropolis Mall, Kolkata', 6);


-- =============================================
-- 7. SCREENS
-- =============================================

INSERT INTO screens (name, total_seats, theater_id) VALUES

-- PVR Phoenix, Mumbai
('Screen 1', 10, 1),
('Screen 2', 8, 1),

-- INOX Nariman Point, Mumbai
('Audi 1', 10, 2),

-- PVR Select City, Delhi
('Screen 1', 10, 3),

-- GOLD Cinema, Delhi
('IMAX', 12, 4),

-- INOX Mantri Mall, Bangalore
('Dolby Atmos', 10, 5),

-- AMB Cinemas, Hyderabad
('Screen 1', 8, 6),

-- SPI Palazzo, Chennai
('Screen 1', 10, 7),

-- INOX South City, Kolkata
('Screen 1', 10, 8),

-- PVR Mani Square, Kolkata
('Screen 1', 10, 9),

-- Cinepolis Acropolis, Kolkata
('Screen 1', 10, 10);


-- =============================================
-- 8. SEATS
-- =============================================

INSERT INTO seats
(seat_number, seat_row, seat_col, seat_type, screen_id)
VALUES

-- Screen 1 - ID 1 - 10 seats
('A1','A',1,'REGULAR',1),
('A2','A',2,'REGULAR',1),
('A3','A',3,'REGULAR',1),
('A4','A',4,'REGULAR',1),
('A5','A',5,'REGULAR',1),
('B1','B',1,'PREMIUM',1),
('B2','B',2,'PREMIUM',1),
('B3','B',3,'PREMIUM',1),
('C1','C',1,'VIP',1),
('C2','C',2,'VIP',1),

-- Screen 2 - ID 2 - 8 seats
('A1','A',1,'REGULAR',2),
('A2','A',2,'REGULAR',2),
('A3','A',3,'REGULAR',2),
('A4','A',4,'REGULAR',2),
('B1','B',1,'PREMIUM',2),
('B2','B',2,'PREMIUM',2),
('B3','B',3,'PREMIUM',2),
('C1','C',1,'VIP',2),

-- Audi 1 - ID 3 - 10 seats
('A1','A',1,'REGULAR',3),
('A2','A',2,'REGULAR',3),
('A3','A',3,'REGULAR',3),
('A4','A',4,'REGULAR',3),
('A5','A',5,'REGULAR',3),
('B1','B',1,'PREMIUM',3),
('B2','B',2,'PREMIUM',3),
('B3','B',3,'PREMIUM',3),
('C1','C',1,'VIP',3),
('C2','C',2,'VIP',3),

-- Screen 1 - ID 4 - 10 seats
('A1','A',1,'REGULAR',4),
('A2','A',2,'REGULAR',4),
('A3','A',3,'REGULAR',4),
('A4','A',4,'REGULAR',4),
('A5','A',5,'REGULAR',4),
('B1','B',1,'PREMIUM',4),
('B2','B',2,'PREMIUM',4),
('B3','B',3,'PREMIUM',4),
('C1','C',1,'VIP',4),
('C2','C',2,'VIP',4),

-- IMAX - ID 5 - 12 seats
('A1','A',1,'REGULAR',5),
('A2','A',2,'REGULAR',5),
('A3','A',3,'REGULAR',5),
('A4','A',4,'REGULAR',5),
('B1','B',1,'PREMIUM',5),
('B2','B',2,'PREMIUM',5),
('B3','B',3,'PREMIUM',5),
('B4','B',4,'PREMIUM',5),
('C1','C',1,'VIP',5),
('C2','C',2,'VIP',5),
('C3','C',3,'VIP',5),
('C4','C',4,'VIP',5),

-- Dolby Atmos - ID 6 - 10 seats
('A1','A',1,'REGULAR',6),
('A2','A',2,'REGULAR',6),
('A3','A',3,'REGULAR',6),
('A4','A',4,'REGULAR',6),
('A5','A',5,'REGULAR',6),
('B1','B',1,'PREMIUM',6),
('B2','B',2,'PREMIUM',6),
('B3','B',3,'PREMIUM',6),
('B4','B',4,'PREMIUM',6),
('C1','C',1,'VIP',6),

-- Screen 1 - ID 7 - 8 seats
('A1','A',1,'REGULAR',7),
('A2','A',2,'REGULAR',7),
('A3','A',3,'REGULAR',7),
('A4','A',4,'REGULAR',7),
('B1','B',1,'PREMIUM',7),
('B2','B',2,'PREMIUM',7),
('B3','B',3,'PREMIUM',7),
('C1','C',1,'VIP',7),

-- Screen 1 - ID 8 - 10 seats
('A1','A',1,'REGULAR',8),
('A2','A',2,'REGULAR',8),
('A3','A',3,'REGULAR',8),
('A4','A',4,'REGULAR',8),
('A5','A',5,'REGULAR',8),
('B1','B',1,'PREMIUM',8),
('B2','B',2,'PREMIUM',8),
('B3','B',3,'PREMIUM',8),
('C1','C',1,'VIP',8),
('C2','C',2,'VIP',8),

-- Screen 1 - ID 9 - 10 seats
('A1','A',1,'REGULAR',9),
('A2','A',2,'REGULAR',9),
('A3','A',3,'REGULAR',9),
('A4','A',4,'REGULAR',9),
('A5','A',5,'REGULAR',9),
('B1','B',1,'PREMIUM',9),
('B2','B',2,'PREMIUM',9),
('B3','B',3,'PREMIUM',9),
('C1','C',1,'VIP',9),
('C2','C',2,'VIP',9),

-- Screen 1 - ID 10 - 10 seats
('A1','A',1,'REGULAR',10),
('A2','A',2,'REGULAR',10),
('A3','A',3,'REGULAR',10),
('A4','A',4,'REGULAR',10),
('A5','A',5,'REGULAR',10),
('B1','B',1,'PREMIUM',10),
('B2','B',2,'PREMIUM',10),
('B3','B',3,'PREMIUM',10),
('C1','C',1,'VIP',10),
('C2','C',2,'VIP',10),

-- Screen 1 - ID 11 - 10 seats
('A1','A',1,'REGULAR',11),
('A2','A',2,'REGULAR',11),
('A3','A',3,'REGULAR',11),
('A4','A',4,'REGULAR',11),
('A5','A',5,'REGULAR',11),
('B1','B',1,'PREMIUM',11),
('B2','B',2,'PREMIUM',11),
('B3','B',3,'PREMIUM',11),
('C1','C',1,'VIP',11),
('C2','C',2,'VIP',11);


-- =============================================
-- 9. SHOWS
-- =============================================

INSERT INTO shows
(movie_id, screen_id, show_date, start_time, end_time, ticket_price)
VALUES

-- PVR Phoenix, Mumbai - Screen 1
(1, 1, '2026-09-10', '10:00:00', '12:30:00', 250.00),
(1, 1, '2026-09-10', '14:00:00', '16:30:00', 300.00),

-- PVR Phoenix, Mumbai - Screen 2
(2, 2, '2026-09-10', '11:00:00', '13:40:00', 200.00),

-- INOX Nariman Point, Mumbai - Audi 1
(4, 3, '2026-09-10', '18:00:00', '20:35:00', 350.00),

-- PVR Select City, Delhi - Screen 1
(5, 4, '2026-09-10', '15:00:00', '17:20:00', 250.00),

-- GOLD Cinema, Delhi - IMAX
(3, 5, '2026-09-10', '18:00:00', '21:00:00', 450.00),

-- INOX Mantri Mall, Bangalore - Dolby Atmos
(4, 6, '2026-09-10', '20:00:00', '22:35:00', 400.00),

-- AMB Cinemas, Hyderabad - Screen 1
(1, 7, '2026-09-11', '10:00:00', '12:30:00', 300.00),

-- SPI Palazzo, Chennai - Screen 1
(2, 8, '2026-09-11', '14:00:00', '16:40:00', 250.00),

-- INOX South City, Kolkata - Screen 1
(1, 9, '2026-09-11', '10:00:00', '12:30:00', 250.00),
(3, 9, '2026-09-11', '18:00:00', '21:00:00', 400.00),

-- PVR Mani Square, Kolkata - Screen 1
(2, 10, '2026-09-11', '11:00:00', '13:40:00', 250.00),
(5, 10, '2026-09-11', '15:00:00', '17:20:00', 250.00),

-- Cinepolis Acropolis, Kolkata - Screen 1
(4, 11, '2026-09-11', '14:00:00', '16:35:00', 300.00),
(3, 11, '2026-09-11', '19:00:00', '22:00:00', 450.00);


-- =============================================
-- 10. BOOKINGS
-- =============================================

INSERT INTO bookings
(user_id, show_id, total_price, status, booked_at)
VALUES
(1, 1, 500.00, 'CONFIRMED', NOW()),
(2, 3, 200.00, 'CONFIRMED', NOW()),
(3, 6, 900.00, 'CONFIRMED', NOW()),
(4, 10, 250.00, 'CANCELLED', NOW());


-- =============================================
-- 11. BOOKING SEATS
-- =============================================

INSERT INTO booking_seats (booking_id, seat_id)
VALUES
(1, 1),
(1, 2),
(2, 11),
(3, 43),
(3, 44),
(4, 81);

