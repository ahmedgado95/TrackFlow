//
//  CardsView.swift
//  TrackFlow
//
//  Created by Ahmed Gado on 10/11/2026.
//


import SwiftUI

struct CardsView: View {
    let trackingManager: TrackingManager

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "creditcard.fill")
                .font(.system(size: 45))
                .foregroundStyle(.blue)

            Text("My Cards")
                .font(.title.bold())

            NavigationLink {
                CardDetailsView(
                    trackingManager: trackingManager
                )
            } label: {
                HStack {
                    Image(systemName: "creditcard")
                    VStack(alignment: .leading) {
                        Text("Demo Card")
                            .font(.headline)

                        Text("**** **** **** 1234")
                            .font(.caption)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                }
                .padding()
                .background(.gray.opacity(0.1))
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
            }
            .buttonStyle(.plain)
            .simultaneousGesture(
                TapGesture().onEnded {
                    trackingManager.track(
                        TrackingEvent(
                            eventName: "screen_transitioned",
                            screenName: "CardsView",
                            userId: "demo_user_001",
                            details: [
                                "fromScreen": "CardsView",
                                "toScreen": "CardDetailsView"
                            ]
                        )
                    )
                }
            )

            Spacer()
        }
        .padding()
        .navigationTitle("Cards")
        .onAppear {
            trackingManager.track(
                TrackingEvent(
                    eventName: "screen_opened",
                    screenName: "CardsView",
                    userId: "demo_user_001"
                )
            )
        }
    }
}
