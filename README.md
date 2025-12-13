# 🟣 PayDash - Modern Fintech Dashboard

A high-performance, aesthetically pleasing Fintech Dashboard built with **Flutter**.
This project demonstrates advanced state management, local persistence, and secure authentication flows in a clean architecture.

## 📱 Features

* **🔐 Secure Authentication:** Custom PIN-based login system (`1-2-3-4`) with secure session management.
* **💸 Smart Transactions:** Complete transfer flow with recipient selection and real-time balance updates.
* **🧠 Local Persistence:** Built with **Hive** (NoSQL) to persist transactions and user balance across sessions.
* **🎨 Dynamic Theming:** Custom "Electric Violet" (Dark) and "Crisp Lavender" (Light) modes using `Bloc` state management.
* **🛡️ Validation:** Prevents overspending (Insufficient Funds) and handles secure navigation.

## 📸 App Screenshots

| **Secure Login** | **Smart Dashboard** | **Recipient Selection** |
|:---:|:---:|:---:|
| <img src="screenshots/login.png" width="250" /> | <img src="screenshots/dashboard_dark.jpg" width="250" /> | <img src="screenshots/receipent.png" width="250" /> |
| Custom PIN Security | Real-time Balance & Transactions | Smart Favorites & Search |

| **Transfer Amount** | **Profile & Settings** | **Dynamic Light Mode** |
|:---:|:---:|:---:|
| <img src="screenshots/pay_request.png" width="250" /> | <img src="screenshots/profile.png" width="250" /> | <img src="screenshots/home_light.jpg" width="250" /> |
| Input Validation Logic | Theme Toggle & Logout | Lavender/White Theme |

## 🛠️ Tech Stack

* **Framework:** Flutter (Dart)
* **State Management:** `flutter_bloc` (Cubit)
* **Database:** `hive` & `hive_flutter` (TypeAdapters generated with `build_runner`)
* **Architecture:** Feature-first, Clean Architecture

## 🚀 How to Run

1.  **Clone the repo:**
    ```bash
    git clone [https://github.com/your-username/paydash.git](https://github.com/your-username/paydash.git)
    ```
2.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run the Generator (for Hive):**
    ```bash
    flutter pub run build_runner build
    ```
4.  **Run the App:**
    ```bash
    flutter run
    ```
