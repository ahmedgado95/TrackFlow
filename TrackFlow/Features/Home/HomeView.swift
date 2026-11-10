
import SwiftUI

struct HomeView: View {

    let trackingManager: TrackingManager
    let networkManager: NetworkManager

    @State private var responseText = "No request yet"
    @State private var isLoading = false

    var body: some View {

        NavigationStack {

            VStack(spacing: 24) {
                Image(systemName: "waveform.path.ecg")
                    .font(.system(size: 55))
                    .foregroundStyle(.blue)

                Text("TrackFlow")
                    .font(.largeTitle.bold())

                Text("Remote iOS Debugging Demo")
                    .foregroundStyle(.secondary)

                Button {
                    trackingManager.track(
                        TrackingEvent(
                            eventName: "button_tapped",
                            screenName: "HomeView",
                            userId: "demo_user_001",
                            details: [
                                "buttonName": "Test API Request"
                            ]
                        )
                    )

                    Task {
                        await fetchPost()
                    }
                } label: {
                    HStack {
                        if isLoading {
                            ProgressView()
                        }
                        Text("Test API Request")
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(isLoading)

                Divider()

                VStack(spacing: 12) {
                    Text("Navigation")
                        .font(.headline)

                    NavigationLink {
                        CardsView(
                            trackingManager: trackingManager
                        )
                    } label: {
                        Label("View Cards", systemImage: "creditcard")
                            .frame(maxWidth: .infinity)
                    }
                    .simultaneousGesture(
                        TapGesture().onEnded {
                            // Track button tap
                            trackingManager.track(
                                TrackingEvent(
                                    eventName: "button_tapped",
                                    screenName: "HomeView",
                                    userId: "demo_user_001",
                                    details: [
                                        "buttonName": "View Cards"
                                    ]
                                )
                            )

                            // Track screen transition
                            trackingManager.track(
                                TrackingEvent(
                                    eventName: "screen_transitioned",
                                    screenName: "HomeView",
                                    userId: "demo_user_001",
                                    details: [
                                        "fromScreen": "HomeView",
                                        "toScreen": "CardsView"
                                    ]
                                )
                            )
                        }
                    )
                    .buttonStyle(.bordered)

                    NavigationLink {
                        TransactionsView(
                            trackingManager: trackingManager
                        )
                    } label: {
                        Label("View Transactions", systemImage: "list.bullet.rectangle")
                            .frame(maxWidth: .infinity)
                    }
                    .simultaneousGesture(
                        TapGesture().onEnded {
                            // Track button tap
                            trackingManager.track(
                                TrackingEvent(
                                    eventName: "button_tapped",
                                    screenName: "HomeView",
                                    userId: "demo_user_001",
                                    details: [
                                        "buttonName": "View Transactions"
                                    ]
                                )
                            )

                            // Track screen transition
                            trackingManager.track(
                                TrackingEvent(
                                    eventName: "screen_transitioned",
                                    screenName: "HomeView",
                                    userId: "demo_user_001",
                                    details: [
                                        "fromScreen": "HomeView",
                                        "toScreen": "TransactionsView"
                                    ]
                                )
                            )
                        }
                    )
                    .buttonStyle(.bordered)
                }

                ScrollView {
                    Text(responseText)
                        .font(.system(.caption, design: .monospaced))
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .padding()
                }
                .background(.gray.opacity(0.1))
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )

                Spacer()
            }
            .padding()
            .navigationTitle("Home")
            .onAppear {
                trackingManager.track(
                    TrackingEvent(
                        eventName: "screen_opened",
                        screenName: "HomeView",
                        userId: "demo_user_001"
                    )
                )
            }
        }
    }

    @MainActor
    private func fetchPost() async {

        isLoading = true
        defer { isLoading = false }

        trackingManager.track(
            TrackingEvent(
                eventName: "api_request_started",
                screenName: "HomeView",
                userId: "demo_user_001",
                details: [
                    "endpoint": "get",
                    "method": "GET"
                ]
            )
        )

        let request = APIRequest(
            endpoint: "get",
            method: .get,
            headers: [
                "Accept": "application/json",
            ],
            body: nil
        )

        do {

            let data = try await networkManager.request(request)

            if let json = try? JSONSerialization.jsonObject(
                with: data,
                options: [.fragmentsAllowed]
            ),
            let prettyData = try? JSONSerialization.data(
                withJSONObject: json,
                options: [.prettyPrinted, .fragmentsAllowed]
            ) {

                responseText = String(
                    decoding: prettyData,
                    as: UTF8.self
                )

            } else {

                responseText = String(
                    decoding: data,
                    as: UTF8.self
                )
            }

        } catch {

            responseText = error.localizedDescription
        }
    }
}
