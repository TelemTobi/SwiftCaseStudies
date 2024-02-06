//
//  HomeReducer.swift
//  SwiftCaseStudies
//
//  Created by Telem Tobi on 06/02/2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct HomeReducer {
    
    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
    }
    
    enum Action {
        case onTransferTap
        case onRequestTap
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onTransferTap:
                return .none
                
            case .onRequestTap:
                return .none
            }
        }
    }
}

extension HomeReducer {
    
    @Reducer
    struct Destination {
        
        @ObservableState
        enum State: Equatable {
            case transfer
            case request
        }
        
        enum Action {
            case transfer
            case request
        }
        
        var body: some ReducerOf<Self> {
            Reduce { state, action in
                return .none
            }
        }
    }
}
