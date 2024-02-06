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
        Reduce { state, action in
            switch action {
            case .root, .path:
                return .none
            }
        }
    }
}

extension TransferNavigator {
    
    @Reducer
    struct Path {
        
        @ObservableState
        enum State: Equatable {
            case contacts(ContactsReducer.State)
        }
        
        enum Action {
            case contacts(ContactsReducer.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: \.contacts, action: \.contacts, child: ContactsReducer.init)
        }
    }
}
