//
//  TransferContentView.swift
//  SwiftCaseStudies
//
//  Created by Telem Tobi on 06/02/2024.
//

import SwiftUI
import ComposableArchitecture

extension TransferNavigator {
    
    struct ContentView: View {
        
        @Bindable var store: StoreOf<TransferNavigator>
        
        var body: some View {
            NavigationStack(
                path: $store.scope(state: \.path, action: \.path),
                root: { ContactsView(store: store.scope(state: \.root, action: \.root)) },
                destination: { store in
                    switch store.state {
                    case .contacts:
                        if let store = store.scope(state: \.contacts, action: \.contacts) {
                            ContactsView(store: store)
                        }
                    }
                }
            )
        }
    }
}
