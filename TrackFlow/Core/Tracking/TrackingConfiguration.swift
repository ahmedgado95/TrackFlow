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
    let webhookAuthKey: String?

    static let development = TrackingConfiguration(
        isEnabled: true,
        webhookURL: nil,
        webhookAuthKey: nil
    )

    static let production = TrackingConfiguration(
        isEnabled: true,
        webhookURL: URL(
            string: "https://ahmedgado.app.n8n.cloud/webhook/trackflow-events"
        ),
        webhookAuthKey: ProcessInfo.processInfo.environment["TRACKFLOW_WEBHOOK_KEY"]
    )
}
