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
                action: { },
                label: {
                    Label("Transfer", systemImage: "arrow.up.right")
                }
            )
            .tint(.pink)
            
            Button(
                action: { },
                label: {
                    Label("Request", systemImage: "arrow.down.left")
                }
            )
            .tint(.teal)
        }
        .bold()
        .buttonStyle(.borderedProminent)
        .frame(maxWidth: .infinity)
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
