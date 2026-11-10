//
//  TransactionsView.swift
//  TrackFlow
//
//  Created by Ahmed Gado on 10/11/2026.
//


import SwiftUI

struct TransactionsView: View {
    let trackingManager: TrackingManager

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "list.bullet.rectangle")
                .font(.system(size: 50))
                .foregroundStyle(.blue)

            Text("Transactions Screen")
                .font(.title.bold())
        }
        .navigationTitle("Transactions")
        .onAppear {
            trackingManager.track(
                TrackingEvent(
                    eventName: "screen_opened",
                    screenName: "TransactionsView",
                    userId: "demo_user_001"
                )
            )
        }
    }
}

