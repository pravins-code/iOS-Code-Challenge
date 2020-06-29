//
//  CCNetworkDataManagerTests.swift
//  CodeChallengeTests
//
//  Created by baps on 29/06/20.
//  Copyright © 2020 own. All rights reserved.
//

import XCTest
@testable import CodeChallenge

class NetworkDataManagerTests: XCTestCase {

    private var networkDataManager: CCNetworkDataManager?
    private var data: Data?

    override func setUp() {
        networkDataManager = CCNetworkDataManager()
    }

    override func tearDown() {
    }
    
    func testErrorReadingData() {
        let url = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json "

        if let networkManager = self.networkDataManager {
            networkManager.readData(with: url, completion: { data,error  in
                if data != nil {
                    
                } else {
                    XCTAssertNil(data)
                }
            })
        }
    }

    func testNetworkServiceResponse() {
        let url = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"

        if let networkManager = self.networkDataManager {
            networkManager.readData(with: url, completion: { data, error  in
                XCTAssertNotNil(data)
            })
        }
    }
    
    func testParseData() {
        
    }
    
    func testResponseDataParsing() {
        let url = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"

        if let networkManager = self.networkDataManager {
            networkManager.readData(with: url, completion: { [unowned self] (data, error)  in
                if data != nil {
                    if let dataList = self.networkDataManager!.parseItemData(data!) {
                        XCTAssertNotNil(dataList)
                        XCTAssertEqual(dataList.count, 34)
                    }
                }
            })
        }
    }

    func testPerformanceExample() {
        let url = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"

        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            if let networkManager = self.networkDataManager {
                networkManager.readData(with: url, completion: { [unowned self] (data, error)  in
                    if data != nil {
                        if let dataList = self.networkDataManager!.parseItemData(data!) {
                            XCTAssertNotNil(dataList)
                            XCTAssertEqual(dataList.count, 34)
                        }
                    }
                })
            }
        }
    }
}