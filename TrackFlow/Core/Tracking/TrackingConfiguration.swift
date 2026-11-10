//
//  TrackingConfiguration.swift
//  TrackFlow
//
//  Created by Ahmed Gado on 10/11/2026.
//


import Foundation

struct TrackingConfiguration {

    let isEnabled: Bool
    let webhookURL: URL?

    static let development = TrackingConfiguration(
        isEnabled: true,
        webhookURL: nil
    )

    static let production = TrackingConfiguration(
        isEnabled: false,
        webhookURL: nil
    )
}
