//
//  NetworkLog.swift
//  TrackFlow
//
//  Created by Ahmed Gado on 10/11/2026.
//


import Foundation

struct NetworkLog: Codable, Identifiable {

    let id: UUID

    let url: String
    let method: String

    let requestHeaders: [String: String]
    let requestBody: String?

    let responseHeaders: [String: String]
    let responseBody: String?

    let statusCode: Int?
    let duration: Double

    let error: String?
    let timestamp: Date
}
