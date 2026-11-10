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

### Phase 1: Project Initialization & Event Tracking <badge color="success">Completed</badge>

- [x] Initialize the SwiftUI project.
- [x] Create the initial project structure.
- [x] Implement the TrackingEvent model.
- [x] Implement TrackingConfiguration.
- [x] Implement TrackingManager.
- [x] Integrate event tracking into HomeView.
- [x] Verify event tracking in the Xcode Console.

**Test Result:**

Successfully captured the following event:

```text
Event: screen_opened
Screen: HomeView
User: demo_user_001
```

The event was successfully generated and printed in the Xcode Console.


## Phase 2: Network Request & Response Tracking

**Status: Completed**

### Implemented
- [x] APIRequest model for building HTTP requests.
- [x] NetworkLog model for storing network activity.
- [x] NetworkLogger for logging requests and responses.
- [x] Sensitive data redaction for request/response headers and JSON bodies.
- [x] URL query parameter redaction.
- [x] NetworkManager using URLSession.
- [x] Request duration measurement.
- [x] HTTP status code tracking.
- [x] HTTP error detection (4xx / 5xx).
- [x] Network transport error logging.

### Testing
- [x] Successful HTTPS request using HTTPBin.
- [x] HTTP 200 response logging.
- [x] HTTP 404 response detection.
- [x] Request and response headers logging.
- [x] JSON response body logging.
- [x] Sensitive Authorization header redaction.
- [x] Sensitive data redaction inside JSON response bodies.
- [x] Network request duration measurement.

### Test Environment
- API: https://httpbin.org
- Successful endpoint: GET /get
- Error endpoint: GET /status/404


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
