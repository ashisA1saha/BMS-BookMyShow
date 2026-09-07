# 🎬 BookMyShow Clone

A full-stack movie ticket booking application inspired by BookMyShow, built using **Java Spring Boot, MySQL, HTML, CSS, and JavaScript**.

## ✨ Features

### 👤 User Features
- User registration and login
- Browse movies and movie details
- Browse theaters and shows
- View available seats
- Select seats and book tickets
- View personal bookings
- Logout

### 🛠️ Admin Features
- Role-based admin access
- Admin section available to users with the `ADMIN` role
- Regular users do not see the Admin link

## 🧰 Technologies Used

**Backend:** Java 21, Spring Boot 4.0.3, Spring Data JPA, Hibernate, Maven

**Database:** MySQL 8

**Frontend:** HTML5, CSS3, JavaScript

**Tools:** IntelliJ IDEA, Git, GitHub

## 📁 Project Structure

```text
BMS/
├── .mvn/
│   └── wrapper/
├── UI/
│   └── UI/
├── src/
│   └── main/
│       ├── java/
│       └── resources/
│           ├── static/
│           └── application.properties
├── .gitignore
├── mvnw
├── mvnw.cmd
└── pom.xml
```

## ⚙️ Prerequisites

Install:
- Java 21
- MySQL 8
- IntelliJ IDEA or another Java IDE
- Git

Maven is optional because the project includes the Maven Wrapper.

## 🗄️ Database Setup

1. Start MySQL 8.
2. Create/configure the database required by the application.
3. Open:

```text
src/main/resources/application.properties
```

4. Configure your own local MySQL username, password, and database settings.

> **Important:** Never commit real database passwords, API keys, or other secrets to a public GitHub repository.

## ▶️ How to Run

### 1. Clone the repository

```bash
git clone https://github.com/ashisA1saha/BMS-BookMyShow.git
```

### 2. Open the project

Open the cloned project in IntelliJ IDEA.

### 3. Configure MySQL

Update `src/main/resources/application.properties` with your own local MySQL credentials.

### 4. Start the application

Run the Spring Boot application from IntelliJ.

Or use the Maven Wrapper:

**Windows**
```bash
mvnw.cmd spring-boot:run
```

**macOS/Linux**
```bash
./mvnw spring-boot:run
```

### 5. Open the application

```text
http://localhost:8080/
```

## 🔐 Demo Admin Accounts

| Email | Password | Role |
|---|---|---|
| admin1@bms.com | admin123 | ADMIN |
| admin2@bms.com | admin123 | ADMIN |

> These credentials are for local/demo use only.

## 👥 User Roles

- **USER** — normal registered users
- **ADMIN** — administrator users with access to the Admin section

New normal registrations are assigned the `USER` role.

## 🔌 Backend API Examples

```text
GET /api/movies
GET /api/movies/{id}
GET /api/cities
GET /api/theaters
GET /api/screens
GET /api/seats/screen/{screenId}
GET /api/shows
GET /api/users
GET /api/bookings/{userId}
GET /api/bookings/show/{showId}/available-seats
```

## 🌐 Application Flow

```text
User
  │
  ├── Register / Login
  ├── Browse Movies
  ├── Select Theater
  ├── Select Show
  ├── Select Seats
  ├── Confirm Booking
  └── View My Bookings
```

Admin flow:

```text
Admin Login
    │
    └── Admin Section
```

## 🔒 Security Note

This is an educational/demo project. For production use, additional security should be implemented, including secure password hashing, stronger authentication and authorization, environment-based secret management, input validation, and production database security.

Never commit real passwords or sensitive credentials to a public repository.

## 📌 Project Status

**Status: ✅ Working full-stack project**

The application has been tested locally with the Spring Boot backend, MySQL database, frontend pages, movie APIs, theater APIs, show APIs, seat APIs, user APIs, and booking APIs.

## 👨‍💻 Author

**Ashis Saha**

GitHub: https://github.com/ashisA1saha

## ⭐ Acknowledgement

This project is an educational implementation inspired by online movie ticket booking platforms such as BookMyShow.

**This project is for educational purposes and is not affiliated with BookMyShow.**
