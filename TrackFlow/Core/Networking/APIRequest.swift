//
//  APIRequest.swift
//  TrackFlow
//
//  Created by Ahmed Gado on 10/11/2026.
//


import Foundation

struct APIRequest {

    let endpoint: String
    let method: HTTPMethod
    let headers: [String: String]
    let body: Data?

    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }

    func makeURLRequest(baseURL: URL) -> URLRequest? {

        guard let url = URL(
            string: endpoint,
            relativeTo: baseURL
        )?.absoluteURL else {
            return nil
        }

        var request = URLRequest(url: url)

        request.httpMethod = method.rawValue
        request.httpBody = body

        headers.forEach { key, value in
            request.setValue(
                value,
                forHTTPHeaderField: key
            )
        }

        return request
    }
}
