//
//  ObservationDemo.swift
//  SwiftCaseStudies
//
//  Created by Telem Tobi on 02/02/2024.
//

import SwiftUI
import ComposableArchitecture

// MARK: - Pre-Observation

class PreCounterViewModel: ObservableObject {
    @Published var count: Int = 0
    @Published var isVisible: Bool = true
}

struct PreCounterView: View {
    @StateObject private var viewModel = PreCounterViewModel()
    
    var body: some View {
        let _ = Self._printChanges()
        
        VStack {
            if viewModel.isVisible {
                Text(viewModel.count.description)
            }
            
            HStack {
                Button("-") { viewModel.count -= 1 }
                Button("+") { viewModel.count += 1 }
            }
            .buttonStyle(.borderedProminent)
            
            Button("Toggle Visibility") {
                viewModel.isVisible.toggle()
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .animation(.snappy, value: viewModel.isVisible)
        .navigationTitle("Observation Demo")
    }
}

// MARK: - Post-Observation

@Reducer
struct CounterFeature {
    
    @ObservableState
    struct State: Equatable {
        var count: Int = 0
        var isVisible: Bool = true
        var text: String = ""
    }
    
    enum Action {
        case incrementCounter
        case decrementCounter
        case toggleVisibility
        case setText(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .incrementCounter:
                state.count += 1
                return .none
            
            case .decrementCounter:
                state.count -= 1
                return .none
            
            case .toggleVisibility:
                state.isVisible.toggle()
                return .none
                
            case let .setText(text):
                state.text = text
                return .none
            }
        }
    }
}

struct PostCounterView: View {
    
    @Bindable var store: StoreOf<CounterFeature>
    
    var body: some View {
        let _ = Self._printChanges()
        
        VStack {
            if store.isVisible {
                Text(store.count.description)
            }
            
            HStack {
                Button("-") { store.send(.incrementCounter) }
                Button("+") { store.send(.decrementCounter) }
            }
            .buttonStyle(.borderedProminent)
            
            Button("Toggle Visibility") {
                store.send(.toggleVisibility)
            }
            .buttonStyle(.bordered)
            
            TextField("Testing TextField", text: $store.text.sending(\.setText))
            Text(store.text)
        }
        .padding()
        .animation(.snappy, value: store.isVisible)
    }
}

#Preview {
    NavigationStack {
        PostCounterView(store: .init(initialState: .init(), reducer: {
            CounterFeature()
        }))
    }
}
