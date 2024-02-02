//
//  01-Observation-Demo.swift
//  SwiftCaseStudies
//
//  Created by Telem Tobi on 02/02/2024.
//

import SwiftUI

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
    }
}

// MARK: - Post-Observation

@Observable
class PostCounterViewModel {
    var count: Int = 0
    var isVisible: Bool = true
}

struct PostCounterView: View {
    private let viewModel = PostCounterViewModel()
    
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
    }
}

#Preview {
    PreCounterView()
}
