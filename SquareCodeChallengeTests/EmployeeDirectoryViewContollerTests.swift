//
//  EmployeeDirectoryViewContollerTests.swift
//  SquareCodeChallengeTests
//
//  Created by Khadija Daruwala on 2023-07-18.
//

import XCTest

@testable import SquareCodeChallenge

final class EmployeeDirectoryViewControllerTests: XCTestCase {
    var viewController: EmployeeDirectoryViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "EmployeeDirectoryViewController") as? EmployeeDirectoryViewController
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testTableViewDataSource() {
        XCTAssertTrue(viewController.tableView.dataSource is EmployeeDirectoryViewController)
    }
    
    func testTableViewDelegate() {
        XCTAssertTrue(viewController.tableView.delegate is EmployeeDirectoryViewController)
    }
    
    func testReloadEmployees() {
        let expectation = XCTestExpectation(description: "Reload employees")
        
        viewController.reloadEmployees()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertTrue(self.viewController.employees.count > 0, "Reloaded employees should not be empty")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
