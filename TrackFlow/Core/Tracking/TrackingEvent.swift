//
//  TrackingEvent.swift
//  TrackFlow
//
//  Created by Ahmed Gado on 10/11/2026.
//


import Foundation

struct TrackingEvent: Codable, Identifiable {

    let id: UUID
    let eventName: String
    let screenName: String
    let userId: String
    let timestamp: Date
    let details: [String: String]

    init(
        eventName: String,
        screenName: String,
        userId: String,
        details: [String: String] = [:]
    ) {
        self.id = UUID()
        self.eventName = eventName
        self.screenName = screenName
        self.userId = userId
        self.timestamp = Date()
        self.details = details
    }
}
