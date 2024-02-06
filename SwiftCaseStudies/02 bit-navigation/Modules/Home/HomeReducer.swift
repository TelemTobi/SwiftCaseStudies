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
        case destination(PresentationAction<Destination.Action>)
        case onTransferTap
        case onRequestTap
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onTransferTap:
                state.destination = .transfer(TransferNavigator.State())
                return .none
                
            case .onRequestTap:
                return .none
                
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination) {
            Destination()
        }
    }
}

extension HomeReducer {
    
    @Reducer
    struct Destination {
        
        @ObservableState
        enum State: Equatable {
            case transfer(TransferNavigator.State)
            case request
        }
        
        enum Action {
            case transfer(TransferNavigator.Action)
            case request
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: \.transfer, action: \.transfer, child: TransferNavigator.init)
        }
    }
}
