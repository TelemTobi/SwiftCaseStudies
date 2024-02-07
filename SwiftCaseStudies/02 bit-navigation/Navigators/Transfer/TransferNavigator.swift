//
//  TransferNavigator.swift
//  SwiftCaseStudies
//
//  Created by Telem Tobi on 06/02/2024.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct TransferNavigator {
    
    @ObservableState
    struct State: Equatable {
        var root = ContactsReducer.State()
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case root(ContactsReducer.Action)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    @Dependency(\.dismiss) private var dismiss
    
    var body: some ReducerOf<Self> {
        Scope(state: \.root, action: \.root, child: ContactsReducer.init)
        
        Reduce { state, action in
            switch action {
            case .root(.onContinueTap):
                state.path.append(.amount(AmountReducer.State()))
                return .none
                
            case .path(.element(_, action: .amount(.onContinueTap))):
                state.path.append(.reason(ReasonReducer.State()))
                return .none
                
            case .root(.onCloseTap),
                 .path(.element(_, action: .amount(.onCloseTap))),
                 .path(.element(_, action: .reason(.onCloseTap))):
                return .run { _ in
                    await dismiss()
                }
                
            case .root, .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
    }
}

extension TransferNavigator {
    
    @Reducer
    struct Path {
        
        @ObservableState
        enum State: Equatable {
            case amount(AmountReducer.State)
            case reason(ReasonReducer.State)
        }
        
        enum Action {
            case amount(AmountReducer.Action)
            case reason(ReasonReducer.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: \.amount, action: \.amount, child: AmountReducer.init)
            Scope(state: \.reason, action: \.reason, child: ReasonReducer.init)
        }
    }
}
