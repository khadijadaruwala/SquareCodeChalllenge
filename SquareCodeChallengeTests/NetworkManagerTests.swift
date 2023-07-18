//
//  SquareCodeChallengeTests.swift
//  SquareCodeChallengeTests
//
//  Created by Khadija Daruwala on 2023-07-16.
//

import XCTest
@testable import SquareCodeChallenge

final class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager.shared
    }
    
    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }
    
    func testGetEmployees() {
        let expectation = XCTestExpectation(description: "Fetch employees")
        
        networkManager.getEmployees { result in
            switch result {
            case .success(let employees):
                XCTAssertFalse(employees.isEmpty, "Fetched employees should not be empty")
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail("Failed to fetch employees: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
