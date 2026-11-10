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

    init(
        baseURL: URL,
        session: URLSession = .shared,
        logger: NetworkLogger = NetworkLogger()
    ) {
        self.baseURL = baseURL
        self.session = session
        self.logger = logger
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

            throw error
        }
    }
}
