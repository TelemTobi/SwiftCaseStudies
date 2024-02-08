//
//  HomeView.swift
//  SwiftCaseStudies
//
//  Created by Telem Tobi on 06/02/2024.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    
    @Bindable var store: StoreOf<HomeReducer>
    
    var body: some View {
        VStack {
            Button(
                action: { store.send(.onTransferTap) },
                label: {
                    Label("Transfer", systemImage: "arrow.up.right")
                }
            )
            .tint(.pink)
            
            Button(
                action: { store.send(.onRequestTap) },
                label: {
                    Label("Request", systemImage: "arrow.down.left")
                }
            )
            .tint(.teal)
        }
        .bold()
        .buttonStyle(.borderedProminent)
        .fullScreenCover(
            item: $store.scope(state: \.destination, action: \.destination),
            content: { store in
                switch store.state {
                case .transfer:
                    if let store = store.scope(state: \.transfer, action: \.transfer) {
                        TransferNavigator.ContentView(store: store)
                    }
                    
                case .request:
                    if let store = store.scope(state: \.request, action: \.request) {
                        RequestNavigator.ContentView(store: store)
                    }
                }
            }
        )
    }
}

#Preview {
    HomeView(
        store: .init(
            initialState: HomeReducer.State(),
            reducer: { HomeReducer() }
        )
    )
}
