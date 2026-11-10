//
//  TrackingManager.swift
//  TrackFlow
//
//  Created by Ahmed Gado on 10/11/2026.
//


import Foundation

final class TrackingManager {

    private let configuration: TrackingConfiguration
    private let session: URLSession

    init(
        configuration: TrackingConfiguration,
        session: URLSession = .shared
    ) {
        self.configuration = configuration
        self.session = session
    }

    func track(_ event: TrackingEvent) {

        guard configuration.isEnabled else {
            return
        }

        // Local Debug Logging
      
        let detailsDescription = event.details
            .sorted { $0.key < $1.key }
            .map { "\($0.key): \($0.value)" }
            .joined(separator: "\n")

        print("""
        🔍 TRACKING EVENT
        ------------------------------
        Event: \(event.eventName)
        Screen: \(event.screenName)
        User: \(event.userId)
        ID: \(event.id)
        Timestamp: \(event.timestamp)

        Details:
        \(detailsDescription.isEmpty ? "None" : detailsDescription)
        ------------------------------
        """)

        
        // Remote Event Delivery
        guard configuration.webhookURL != nil else {
            return
        }

        Task {
            await send(event)
        }
    }

    private func send(_ event: TrackingEvent) async {

        guard let url = configuration.webhookURL else {
            return
        }

        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            request.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )

            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601

            request.httpBody = try encoder.encode(event)

            let (_, response) = try await session.data(
                for: request
            )

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("❌ Tracking delivery failed")
                return
            }

            print("✅ Event delivered successfully")

        } catch {
            print("❌ Tracking Error: \(error.localizedDescription)")
        }
    }
}
