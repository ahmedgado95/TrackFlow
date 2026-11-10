//
//  TrackFlowApp.swift
//  TrackFlow
//
//  Created by Ahmed Gado on 10/11/2026.
//

import SwiftUI

@main
struct TrackFlowApp: App {

    private let trackingManager = TrackingManager(
        configuration: .development
    )

    private let networkManager = NetworkManager(
        baseURL: URL(
            string: "https://httpbin.org"
        )!
    )

    var body: some Scene {
        WindowGroup {
            HomeView(
                trackingManager: trackingManager,
                networkManager: networkManager
            )
        }
    }
}
