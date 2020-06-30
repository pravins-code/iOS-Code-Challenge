//
//  MainViewModelTests.swift
//  CodeChallengeTests
//
//  Created by Pravin Ghogare on 29/06/20.
//  Copyright © 2020 own. All rights reserved.
//

import XCTest
@testable import CodeChallenge

class MainViewModelTests: XCTestCase {
    
    let mainViewModelObj = CCMainViewModel()

    override func setUp() {
        mainViewModelObj.loadData()
    }

    override func tearDown() {
    }

    func testModelObjectLoadingSuccess() {
        let expectation = self.expectation(description: "Failed reading data")
        mainViewModelObj.readDataCompleted = { (success, error) in
            XCTAssertTrue(success)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testLoadedDataCount() {
        mainViewModelObj.readDataCompleted = { [weak self] (success, error) in
            XCTAssertTrue(success)
            XCTAssertNotNil(self!.mainViewModelObj.dataItemList)
            XCTAssertEqual(self!.mainViewModelObj.dataItemList?.count, 34)
        }
    }

    func testPerformanceExample() {
        // Set the baseline to check the actual time reuired to perform the task with respect to the baseline.
        self.measure {
            mainViewModelObj.loadData()
            // Put the code you want to measure the time of here.
            mainViewModelObj.readDataCompleted = { (success, error) in
            }
        }
    }
}
