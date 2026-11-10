//
//  HomeView.swift
//  TrackFlow
//
//  Created by Ahmed Gado on 10/11/2026.
//


import SwiftUI

struct HomeView: View {

    let trackingManager: TrackingManager

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                Image(systemName: "waveform.path.ecg")
                    .font(.system(size: 55))
                    .foregroundStyle(.blue)

                Text("TrackFlow")
                    .font(.largeTitle.bold())

                Text("Remote iOS Debugging Demo")
                    .foregroundStyle(.secondary)

                Button("Open Card Details") {

                    trackingManager.track(
                        TrackingEvent(
                            eventName: "screen_opened",
                            screenName: "HomeView",
                            userId: "demo_user_001"
                        )
                    )
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}
