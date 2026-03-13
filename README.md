# 💰 Intelligent Personal Finance & Budgeting System

![Flutter](https://img.shields.io/badge/Flutter-Framework-blue)
![Dart](https://img.shields.io/badge/Dart-Language-blue)
![SQLite](https://img.shields.io/badge/Database-SQLite-green)
![License](https://img.shields.io/badge/License-Academic-orange)

---

## 🚀 Overview

Manage your money smarter with the **Intelligent Personal Finance & Budgeting System** – a Flutter app designed to help users:

* Track income & expenses 💸
* Categorize transactions 🗂️
* Analyze spending patterns 📊
* Export summaries for reporting 📑

This app showcases **advanced Flutter concepts** like **clean architecture, state management, local & remote data integration, and device feature usage**.

---

## ✨ Features

### 🔑 Authentication

* Secure login & registration simulation
* Auth-based route protection

### 📝 Transaction Management

* Add, edit, delete income & expense transactions
* Category-based classification
* Pagination for large transaction lists

### 📊 Financial Analytics

* Monthly dashboard with insights
* Category-wise spending charts
* Data visualization with interactive graphs

### 💱 Currency Conversion

* Mock API-based currency conversion

### 📂 Data Export

* Export financial summaries as **CSV**

---

## 🏗️ Technical Implementation

### Navigation

* Named routes for structured navigation
* Nested navigation with **BottomNavigationBar**
* Route guards for authentication

### State Management

* **Provider / Riverpod / Bloc**
* Separation of UI and business logic
* Robust async & error handling

### Clean Architecture

```
lib/
│
├── presentation/   # Screens, widgets, navigation
├── business_logic/ # Providers / Blocs, Services
├── data/           # Models, Repositories, Database, API
└── main.dart
```

---

## 💾 Database Design

**SQLite relational database** with three main tables:

| Table        | Description                     |
| ------------ | ------------------------------- |
| Users        | Stores user login information   |
| Transactions | Stores income & expense records |
| Categories   | Stores transaction categories   |

**Relationships:**

* One User → Many Transactions
* One Category → Many Transactions

---

## ⚡ Performance & UX Optimization

* Lazy loading & pagination
* Loading indicators during async operations
* Form validation & null safety
* Error & exception handling

---

## 📱 Device Features

* CSV file export
* Background tasks for processing
* Optional notifications (financial reminders)

---

## 🛠️ Technologies Used

* Flutter & Dart
* SQLite
* REST APIs
* Provider / Riverpod / Bloc
* Charts & Graphs for analytics

---

## 🎨 Screenshots / Demo

**App Screens:**
![Login Screen](./screenshots/login.png)
![Dashboard](./screenshots/dashboard.png)
![Transaction List](./screenshots/transactions.png)

**Demo GIF:**
![App Demo](./screenshots/demo.gif)

> Replace placeholders with your actual screenshots/GIFs before publishing

---

## ⚙️ Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/finance-budget-app.git

# Navigate to the project folder
cd finance-budget-app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## 👥 Team Responsibilities

| Member   | Responsibility                    |
| -------- | --------------------------------- |
| Member 1 | UI Architecture & Navigation      |
| Member 2 | State Management & Business Logic |
| Member 3 | Database & Data Layer             |
| Member 4 | API Integration & Device Features |

> Each member is responsible for implementing and defending their module during the project viva.

---

## 🎓 Academic Info

* **Course:** ICT4153 – Mobile Application Development
* **Department:** Department of ICT
* **Faculty:** Faculty of Technology
* **University:** University of Ruhuna
* **Year:** 2026

---

## 📜 License

This project is **developed solely for academic purposes**.


Do you want me to do that next?
