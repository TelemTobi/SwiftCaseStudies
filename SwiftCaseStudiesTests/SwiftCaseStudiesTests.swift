//
//  SwiftCaseStudiesTests.swift
//  SwiftCaseStudiesTests
//
//  Created by Telem Tobi on 03/02/2024.
//

import XCTest
@testable import SwiftCaseStudies
import ComposableArchitecture

@MainActor
final class CounterTests: XCTestCase {

    var store: TestStoreOf<CounterFeature>!
    
    override func setUpWithError() throws {
        store = TestStore(
            initialState: CounterFeature.State(),
            reducer: { CounterFeature() }
        )
    }

    override func tearDownWithError() throws {
        store = nil
    }
    
    func testCounter() async {
        XCTAssertEqual(store.state.count, 0)
        
        await store.send(.incrementCounter) { state in
            state.count = 1
        }
    }
}
