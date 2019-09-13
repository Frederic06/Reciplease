//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Margarita Blanc on 20/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import XCTest
@testable import Reciplease

class SearchViewModelTests: XCTestCase {
    
    func testGivenASearchViewModelWhenViewDidLoadThenInitialPropertiesAreCorrecltyReturned() {
        
            let delegate: ResearchViewModelDelegate? = MockSearchCoordinator()

            let viewModel = SearchViewModel(delegate: delegate)
        
        let expectation1 = self.expectation(description: "Returned titleText")
        let expectation2 = self.expectation(description: "Returned viewTitleText")
        let expectation3 = self.expectation(description: "Returned placeHolderTextField")
        let expectation4 = self.expectation(description: "Returned addButtonText")
        let expectation5 = self.expectation(description: "Returned yourIngredientsText")
                let expectation6 = self.expectation(description: "Returned clearButtonText")
                let expectation7 = self.expectation(description: "Returned searchButtonHidden")
                let expectation8 = self.expectation(description: "Returned searchButtonText")

        viewModel.titleText = { text in
            XCTAssertEqual(text, "Recipleased")
            expectation1.fulfill()
        }
        
        viewModel.viewTitleText = { text in
            XCTAssertEqual(text, "What's in your fridge?")
            expectation2.fulfill()
        }
        
        viewModel.placeHolderTextField = { text in
            XCTAssertEqual(text, "Lemon, Cheese, Sausages ...")
            expectation3.fulfill()
        }
        
        viewModel.addButtonText = { text in
            XCTAssertEqual(text, "Add")
            expectation4.fulfill()
        }
        
        viewModel.yourIngredientsText = { text in
            XCTAssertEqual(text, "Your ingredients")
            expectation5.fulfill()
        }
        
        viewModel.clearButtonText = { text in
            XCTAssertEqual(text, "Clear!")
            expectation6.fulfill()
        }
        
        viewModel.searchButtonHidden = { text in
            XCTAssertEqual(text, true)
            expectation7.fulfill()
        }
        
        viewModel.searchButtonText = { text in
            XCTAssertEqual(text, "Search for recipes!!")
            expectation8.fulfill()
        }
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
