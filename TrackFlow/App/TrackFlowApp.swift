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
        configuration: .production
    )

 
    private let networkManager = NetworkManager(
        baseURL: URL(
            string: "https://httpbin.org"
        )!,
        trackingConfiguration: .production
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
