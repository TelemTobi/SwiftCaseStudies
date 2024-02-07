//
//  ContactsView.swift
//  SwiftCaseStudies
//
//  Created by Telem Tobi on 06/02/2024.
//

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {
    
    let store: StoreOf<ContactsReducer>
    
    @Environment(\.themeColor) private var themeColor
    
    var body: some View {
        VStack {
            Spacer()
            
            Button(
                action: { store.send(.didSelectContact("some contact")) },
                label: {
                    Text("Continue")
                        .bold()
                        .frame(height: 45)
                        .frame(maxWidth: .infinity)
                }
            )
            .tint(themeColor)
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
        }
        .navigationTitle("Contacts")
        .toolbar(content: toolbarContent)
    }
    
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(
                action: { store.send(.onCloseTap) },
                label: { Image(systemName: "xmark") }
            )
        }
    }
}

#Preview {
    NavigationStack {
        ContactsView(
            store: .init(
                initialState: ContactsReducer.State(),
                reducer: { ContactsReducer() }
            )
        )
    }
}
