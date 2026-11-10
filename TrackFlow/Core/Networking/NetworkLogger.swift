//
//  NetworkLogger.swift
//  TrackFlow
//
//  Created by Ahmed Gado on 10/11/2026.
//


import Foundation

final class NetworkLogger {

    private let sensitiveKeys: Set<String> = [
        "authorization",
        "token",
        "access_token",
        "refresh_token",
        "password",
        "client_secret",
        "card_number",
        "cardnumber",
        "cvv",
        "pin",
        "api_key",
        "apikey"
    ]

    func log(_ networkLog: NetworkLog) {

        print("""
        
        🌐 NETWORK LOG
        ------------------------------
        URL: \(networkLog.url)
        Method: \(networkLog.method)
        Status: \(networkLog.statusCode.map(String.init) ?? "N/A")
        Duration: \(networkLog.duration)s
        
        Request Headers:
        \(networkLog.requestHeaders)
        
        Request Body:
        \(networkLog.requestBody ?? "None")
        
        Response Headers:
        \(networkLog.responseHeaders)
        
        Response Body:
        \(networkLog.responseBody ?? "None")
        
        Error:
        \(networkLog.error ?? "None")
        ------------------------------
        
        """)
    }

    func redactHeaders(
        _ headers: [String: String]
    ) -> [String: String] {

        var safeHeaders: [String: String] = [:]

        for (key, value) in headers {

            let normalizedKey = key.lowercased()

            let shouldRedact =
                sensitiveKeys.contains(normalizedKey) ||
                normalizedKey.contains("authorization") ||
                normalizedKey.contains("cookie") ||
                normalizedKey.contains("api-key")

            safeHeaders[key] = shouldRedact
                ? "[REDACTED]"
                : value
        }

        return safeHeaders
    }

    func redactBody(_ data: Data?) -> String? {

        guard let data else {
            return nil
        }

        guard var json = try? JSONSerialization.jsonObject(
            with: data,
            options: [.fragmentsAllowed]
        ) else {
            return "[Non-JSON body omitted]"
        }

        redactJSON(&json)

        guard let safeData = try? JSONSerialization.data(
            withJSONObject: json,
            options: [.prettyPrinted, .fragmentsAllowed]
        ) else {
            return "[Unable to serialize body]"
        }

        return String(
            decoding: safeData.prefix(10_000),
            as: UTF8.self
        )
    }

    private func redactJSON(_ object: inout Any) {

        if var dictionary = object as? [String: Any] {

            for key in dictionary.keys {

                if sensitiveKeys.contains(key.lowercased()) {

                    dictionary[key] = "[REDACTED]"

                } else if var nestedValue = dictionary[key] {

                    redactJSON(&nestedValue)
                    dictionary[key] = nestedValue
                }
            }

            object = dictionary

        } else if var array = object as? [Any] {

            for index in array.indices {

                var item = array[index]
                redactJSON(&item)
                array[index] = item
            }

            object = array
        }
    }
}
