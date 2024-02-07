//
//  ReasonView.swift
//  SwiftCaseStudies
//
//  Created by Telem Tobi on 07/02/2024.
//

import SwiftUI
import ComposableArchitecture

struct ReasonView: View {
    
    let store: StoreOf<ReasonReducer>
    
    @Environment(\.themeColor) private var themeColor
    
    var body: some View {
        VStack {
            Spacer()
            
            Button(
                action: { store.send(.didSelectReason("some reason")) },
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
        .navigationTitle("Reason")
        .toolbar(content: toolbarContent)
    }
    
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(
                action: { store.send(.didTapClose) },
                label: { Image(systemName: "xmark") }
            )
        }
    }
}

#Preview {
    NavigationStack {
        ReasonView(
            store: .init(
                initialState: ReasonReducer.State(),
                reducer: { ReasonReducer() }
            )
        )
    }
}
