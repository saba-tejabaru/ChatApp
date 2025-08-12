# Chat Demo — Flutter (Customer & Vendor)

A Flutter mobile application demonstrating a simple chat system for **two roles**:  
- **Customer**  
- **Vendor**

The app supports login, chat listing, viewing chat history, and real-time messaging via socket.io.  
Built using **Flutter**, **Bloc** for state management, and an **MVVM-like** architecture.

---

## 🚀 Features
- **Login** as Customer or Vendor using provided API.
- **Home screen** shows list of chats for logged-in user.
- **Chat screen** displays message history (API).
- **Send message** via API and socket.io for real-time updates.
- **Bloc** for state management (ViewModel role in MVVM).
- Token persistence with **SharedPreferences**.

---

## 🛠 Tech Stack
- **Flutter** (Dart)
- **Bloc** (flutter_bloc)
- **Dio** for HTTP requests
- **Socket.IO** client for real-time messaging
- **SharedPreferences** for local storage

---

## 📦 API Endpoints
Base URL: `http://45.129.87.38:6065`

| Action             | Method | Endpoint |
|--------------------|--------|----------|
| Login              | POST   | `/user/login` |
| Get user chats     | GET    | `/chats/user-chats/:userId` |
| Get chat messages  | GET    | `/messages/get-messagesformobile/:chatId` |
| Send message       | POST   | `/messages/sendMessage` |

**Example login request body:**
```json
{
  "email": "swaroop.vass@gmail.com",
  "password": "@Tyrion99",
  "role": "vendor"
}
