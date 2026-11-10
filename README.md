# TrackFlow

**A Lightweight Remote Debugging & Event Tracking System for iOS**

TrackFlow is an open-source iOS demo project that demonstrates how to build a reusable remote debugging and event tracking system using Swift and SwiftUI.

The main goal is to help iOS developers monitor user interactions, track application events, and inspect API requests and responses remotely without requiring direct access to the user's device or account.

## 🎯 Project Goals

- Track user interactions and screen navigation.
- Monitor API requests and responses.
- Capture HTTP status codes and request execution times.
- Centralize debugging logs using a reusable tracking layer.
- Forward tracking events to Telegram through n8n.
- Demonstrate a practical approach to debugging issues that occur only on specific user devices.

## 🛠️ Technologies

- Swift
- SwiftUI
- MVVM
- URLSession
- Codable
- n8n
- Telegram Bot API

## 📁 Project Structure

```text
TrackFlow/
├── App/
├── Core/
│   ├── Tracking/
│   └── Networking/
├── Features/
│   ├── Home/
│   ├── Cards/
│   └── Transactions/
└── Resources/
```

## 🚀 Development Progress

### Phase 1: Project Initialization & Event Tracking

- [x] Initialize the SwiftUI project.
- [x] Create the initial project structure.
- [x] Implement the TrackingEvent model.
- [x] Implement TrackingConfiguration.
- [x] Implement TrackingManager.
- [x] Add the initial Home screen.
- [ ] Verify event tracking on the iOS Simulator.

### Phase 2: Network Request & Response Tracking

- [ ] Implement APIRequest.
- [ ] Implement NetworkLog.
- [ ] Implement NetworkLogger.
- [ ] Implement NetworkManager.
- [ ] Capture HTTP requests and responses.
- [ ] Measure API execution time.
- [ ] Add sensitive data redaction.

### Phase 3: n8n Integration

- [ ] Create an n8n webhook.
- [ ] Connect the iOS tracking layer to the webhook.
- [ ] Forward event and network logs.

### Phase 4: Telegram Integration

- [ ] Create a Telegram Bot.
- [ ] Configure Telegram notifications in n8n.
- [ ] Send real-time debugging notifications.

## 🔐 Security

TrackFlow is designed with security in mind.

Sensitive information such as authentication tokens, passwords, and payment details should never be exposed in remote debugging logs.

## 📌 Project Status

Currently under development.

More features and implementation details will be added as the project progresses.

## 👨‍💻 Author

**Ahmed Gado**

Senior iOS Engineer

[GitHub](https://github.com/ahmedgado95)

---

*Built to make remote iOS debugging easier and more accessible.*
