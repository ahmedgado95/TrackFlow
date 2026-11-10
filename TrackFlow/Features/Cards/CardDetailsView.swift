//
//  CardDetailsView.swift
//  TrackFlow
//
//  Created by Ahmed Gado on 10/11/2026.
//


import SwiftUI

import SwiftUI

struct CardDetailsView: View {
    let trackingManager: TrackingManager

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "creditcard.fill")
                .font(.system(size: 60))
                .foregroundStyle(.blue)

            Text("Card Details")
                .font(.largeTitle.bold())

            VStack(alignment: .leading, spacing: 12) {
                Text("Card Name: Demo Card")
                Text("Card Number: **** **** **** 1234")
                Text("Card Status: Active")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(.gray.opacity(0.1))
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )

            Spacer()
        }
        .padding()
        .navigationTitle("Card Details")
        .onAppear {
            trackingManager.track(
                TrackingEvent(
                    eventName: "screen_opened",
                    screenName: "CardDetailsView",
                    userId: "demo_user_001"
                )
            )
        }
    }
}
