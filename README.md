# 🟣 PayDash - Modern Fintech Dashboard

[![Live Demo](https://img.shields.io/badge/Live_Demo-Launch_App-purple?style=for-the-badge&logo=firebase)](https://paydash-mostafa-v1.web.app)
[![Flutter](https://img.shields.io/badge/Made_with-Flutter-blue?style=for-the-badge&logo=flutter)](https://flutter.dev)

A high-performance, aesthetically pleasing Fintech Dashboard built with **Flutter Web**.
This project demonstrates advanced state management, local persistence, and secure authentication flows in a clean, scalable architecture.

---

## 🚀 Live Demo
**Try the app instantly here:** [https://paydash-mostafa-v1.web.app](https://paydash-mostafa-v1.web.app)
*(Note: Use PIN `1-2-3-4` to login)*

---

## 📱 Key Features

* **🔐 Secure Authentication:** Custom PIN-based login system with secure session management.
* **💸 Smart Transactions:** Complete money transfer flow with recipient validation, input logic, and real-time balance updates.
* **🧠 Local Persistence:** Built with **Hive** (NoSQL) to persist transaction history and balance across sessions (even after page refresh).
* **📊 Analytics & History:** Interactive curved line charts (using `fl_chart`) and detailed transaction history logs.
* **🎨 Dynamic Theming:** Robust Theme Engine allowing instant toggling between "Electric Violet" (Dark) and "Crisp Lavender" (Light) modes.
* **🛡️ Error Handling:** Validates "Insufficient Funds," network errors, and invalid inputs gracefully.

---

## 📸 App Screenshots

| **Secure Login** | **Smart Dashboard** | **Spending Analytics** |
|:---:|:---:|:---:|
| <img src="screenshots/login.png" width="250" /> | <img src="screenshots/dashboard_dark.png" width="250" /> | <img src="screenshots/analytics.png" width="250" /> |
| Custom PIN Security | Real-time Balance & Transactions | Interactive FL Charts |

| **Transfer Amount** | **Recipient Selection** | **Transaction History** |
|:---:|:---:|:---:|
| <img src="screenshots/pay_request.png" width="250" /> | <img src="screenshots/receipent.png" width="250" /> | <img src="screenshots/history.png" width="250" /> |
| Input Validation Logic | Smart Favorites & Search | Complete Activity Log |

| **Profile & Settings** | **Dynamic Light Mode** | |
|:---:|:---:|:---:|
| <img src="screenshots/profile.png" width="250" /> | <img src="screenshots/home_light.png" width="250" /> | |
| Theme Toggle & Logout | Lavender/White Theme | |

---

## 🛠️ Tech Stack

* **Framework:** Flutter 3.x (Dart)
* **State Management:** `flutter_bloc` (Cubit pattern)
* **Local Database:** `hive` & `hive_flutter` (TypeAdapters generated via `build_runner`)
* **Visualization:** `fl_chart` for Analytics
* **Architecture:** Feature-First, Clean Architecture (Domain/Data/Presentation split)

---

## 💻 How to Run Locally

If you prefer to run the code on your own machine:

1.  **Clone the repo:**
    ```bash
    git clone [https://github.com/your-username/paydash.git](https://github.com/your-username/paydash.git)
    cd paydash
    ```

2.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the Generator (for Hive Adapters):**
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the App:**
    ```bash
    flutter run
    ```

---
