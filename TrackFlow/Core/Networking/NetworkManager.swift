//
//  NetworkManager.swift
//  TrackFlow
//
//  Created by Ahmed Gado on 10/11/2026.
//


import Foundation

final class NetworkManager {

    private let baseURL: URL
    private let session: URLSession
    private let logger: NetworkLogger
    private let trackingConfiguration: TrackingConfiguration

    init(
        baseURL: URL,
        session: URLSession = .shared,
        logger: NetworkLogger = NetworkLogger(),
        trackingConfiguration: TrackingConfiguration = .development
    ) {
        self.baseURL = baseURL
        self.session = session
        self.logger = logger
        self.trackingConfiguration = trackingConfiguration
    }

    func request(_ apiRequest: APIRequest) async throws -> Data {

        guard let request = apiRequest.makeURLRequest(
            baseURL: baseURL
        ) else {
            throw URLError(.badURL)
        }

        let startTime = Date()

        do {
            let (data, response) = try await session.data(
                for: request
            )

            let duration = Date().timeIntervalSince(startTime)
            let httpResponse = response as? HTTPURLResponse

            let responseHeaders = httpResponse?
                .allHeaderFields
                .reduce(into: [String: String]()) { result, item in
                    result[String(describing: item.key)] =
                        String(describing: item.value)
                } ?? [:]

            let httpError: String?

            if let httpResponse,
               !(200...299).contains(httpResponse.statusCode) {
                httpError = "HTTP Error: \(httpResponse.statusCode)"
            } else {
                httpError = nil
            }

            let networkLog = NetworkLog(
                id: UUID(),
                url: logger.redactURL(request.url),
                method: request.httpMethod ?? "GET",
                requestHeaders: logger.redactHeaders(
                    request.allHTTPHeaderFields ?? [:]
                ),
                requestBody: logger.redactBody(
                    request.httpBody
                ),
                responseHeaders: logger.redactHeaders(
                    responseHeaders
                ),
                responseBody: logger.redactBody(data),
                statusCode: httpResponse?.statusCode,
                duration: duration,
                error: httpError,
                timestamp: Date()
            )

            logger.log(networkLog)
            deliver(networkLog)

            return data

        } catch {

            let nsError = error as NSError

            print("""
            🚨 NETWORK ERROR DETAILS
            ------------------------------
            Domain: \(nsError.domain)
            Code: \(nsError.code)
            Description: \(nsError.localizedDescription)
            User Info: \(nsError.userInfo)
            Underlying Error: \(String(describing: nsError.userInfo[NSUnderlyingErrorKey]))
            ------------------------------
            """)

            let duration = Date().timeIntervalSince(startTime)

            let networkLog = NetworkLog(
                id: UUID(),
                url: logger.redactURL(request.url),
                method: request.httpMethod ?? "GET",
                requestHeaders: logger.redactHeaders(
                    request.allHTTPHeaderFields ?? [:]
                ),
                requestBody: logger.redactBody(
                    request.httpBody
                ),
                responseHeaders: [:],
                responseBody: nil,
                statusCode: nil,
                duration: duration,
                error: error.localizedDescription,
                timestamp: Date()
            )

            logger.log(networkLog)
            deliver(networkLog)

            throw error
        }
    }

    // MARK: - Remote Network Log Delivery

    private func deliver(_ networkLog: NetworkLog) {

        guard trackingConfiguration.isEnabled,
              trackingConfiguration.webhookURL != nil else {
            return
        }

        Task {
            await send(networkLog)
        }
    }

    private func send(_ networkLog: NetworkLog) async {

        guard let url = trackingConfiguration.webhookURL else {
            return
        }

        guard let authKey = trackingConfiguration.webhookAuthKey,
              !authKey.isEmpty else {
            print("❌ Network log delivery failed: Missing auth key")
            return
        }

        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            request.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )

            request.setValue(
                authKey,
                forHTTPHeaderField: "X-TrackFlow-Key"
            )

            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            request.httpBody = try encoder.encode(networkLog)

            let (_, response) = try await session.data(
                for: request
            )

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("❌ Network log delivery failed")
                return
            }

            print("✅ Network log delivered successfully")

        } catch {
            print(
                "❌ Network log delivery error: \(error.localizedDescription)"
            )
        }
    }
}
