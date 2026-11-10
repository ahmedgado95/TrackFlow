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

## Phase 3: User Interaction & Screen Navigation Tracking

**Status: Completed**

### Implemented
- [x] Track screen_opened events across HomeView, CardsView, CardDetailsView, and TransactionsView.
- [x] Track button_tapped events for user interactions.
- [x] Track screen_transitioned events with source and destination screen details.
- [x] Capture event timestamps and custom event details.
- [x] Log tracking events in the Xcode Console.
- [x] Track navigation from HomeView to CardsView.
- [x] Track navigation from HomeView to TransactionsView.
- [x] Track navigation from CardsView to CardDetailsView.

### Testing
- [x] Verify HomeView screen tracking.
- [x] Verify CardsView screen tracking.
- [x] Verify CardDetailsView screen tracking.
- [x] Verify TransactionsView screen tracking.
- [x] Verify button tap event logging.
- [x] Verify screen transition event logging.
- [x] Verify source and destination screen details.
- [x] Verify event sequence across navigation flows.
- [x] Verify tracking when returning to previously opened screens.

### Notes
- Screen tracking uses SwiftUI's onAppear lifecycle method.
- The onAppear method may be called multiple times when navigating back to a screen.
- Screen transition events are recorded when the user taps a navigation link.
- The destination's screen_opened event confirms that the destination view appeared.
- Tracking events must not contain passwords, authentication tokens, payment card details, or other sensitive information.

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
