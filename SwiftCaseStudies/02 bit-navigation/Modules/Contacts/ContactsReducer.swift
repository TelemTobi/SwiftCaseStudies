//
//  ContactsReducer.swift
//  SwiftCaseStudies
//
//  Created by Telem Tobi on 06/02/2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ContactsReducer {
    
    @ObservableState
    struct State: Equatable {
        
    }
    
    enum Action {
        case onCloseTap
        case didSelectContact(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            // Navigation actions are handled in the parent Navigator reducer
            case .onCloseTap, .didSelectContact:
                return .none
            }
        }
    }
}
