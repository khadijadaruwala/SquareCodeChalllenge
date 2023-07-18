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


//final class SquareCodeChallengeTests: XCTestCase {
//    var networkManager: NetworkManager!
//
//    override func setUp() {
//        super.setUp()
//        networkManager = NetworkManager.shared
//    }
//
//    override func tearDown() {
//        networkManager = nil
//        super.tearDown()
//    }
//
//    func testGetEmployees() {
//        let expectation = XCTestExpectation(description: "Fetch employees")
//
//        networkManager.getEmployees { result in
//            switch result {
//            case .success(let employees):
//                XCTAssertFalse(employees.isEmpty, "Fetched employees should not be empty")
//                expectation.fulfill()
//
//            case .failure(let error):
//                XCTFail("Failed to fetch employees: \(error.localizedDescription)")
//            }
//        }
//
//        wait(for: [expectation], timeout: 5.0)
//    }
//
//}

//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//    func testEmployeeParsing() {
//        let jsonData = """
//            [
//                {
//                    "uuid": "1",
//                    "full_name": "John Doe",
//                    "phone_number": "5556661234",
//                    "email_address": "john.doe@example.com",
//                    "biography": "Short bio",
//                    "photo_url_small": "https://example.com/small.jpg",
//                    "photo_url_large": "https://example.com/large.jpg",
//                    "team": "Engineering",
//                    "employee_type": "FULL_TIME"
//                }
//            ]
//        """.data(using: .utf8)!
//
//        do {
//            let employees = try JSONDecoder().decode([Employee].self, from: jsonData)
//            XCTAssertEqual(employees.count, 1)
//
//            let employee = employees.first!
//            XCTAssertEqual(employee.uuid, "1")
//            XCTAssertEqual(employee.fullName, "John Doe")
//            XCTAssertEqual(employee.phoneNumber, "5556661234")
//            XCTAssertEqual(employee.emailAddress, "john.doe@example.com")
//            XCTAssertEqual(employee.biography, "Short bio")
//            XCTAssertEqual(employee.photoUrlSmall, "https://example.com/small.jpg")
//            XCTAssertEqual(employee.photoUrlLarge, "https://example.com/large.jpg")
//            XCTAssertEqual(employee.team, "Engineering")
//            XCTAssertEqual(employee.employeeType, "FULL_TIME")
//        } catch {
//            XCTFail("Failed to parse employee JSON: \(error.localizedDescription)")
//        }
//    }
//
//    func testEmployeeDirectoryViewController() {
//        let viewController = EmployeeDirectoryViewController()
//
//        // Test initial state
//        XCTAssertEqual(viewController.employees.count, 0)
//        XCTAssertTrue(viewController.tableView.isHidden)
//        XCTAssertTrue(viewController.emptyStateLabel.isHidden)
//        XCTAssertFalse(viewController.activityIndicator.isAnimating)
//
//        // Test loading state
//        viewController.showLoadingState()
//        XCTAssertFalse(viewController.tableView.isHidden)
//        XCTAssertTrue(viewController.emptyStateLabel.isHidden)
//        XCTAssertTrue(viewController.activityIndicator.isAnimating)
//
//        // Test empty state
//        viewController.employees = []
//        viewController.showEmptyStateIfNeeded()
//        XCTAssertTrue(viewController.tableView.isHidden)
//        XCTAssertFalse(viewController.emptyStateLabel.isHidden)
//
//        // Test error state
//        let error = NSError(domain: "Test", code: 0, userInfo: nil)
//        viewController.showErrorState(with: error.localizedDescription)
//        XCTAssertFalse(viewController.tableView.isHidden)
//        XCTAssertTrue(viewController.emptyStateLabel.isHidden)
//
//        // Test hide loading state
//        viewController.hideLoadingState()
//        XCTAssertFalse(viewController.activityIndicator.isAnimating)
//    }
//
////    func testImageCaching() {
////        let cacheManager = ImageCacheManager.shared
////
////        let expectation = XCTestExpectation(description: "Image loaded from cache")
////
////        let imageURL = "https://example.com/image.jpg"
////
////        // First request - Image should be fetched from the network
////        cacheManager.loadImage(from: imageURL) { result in
////            switch result {
////            case .success(let image):
////                XCTAssertNotNil(image)
////
////                // Second request - Image should be loaded from cache
////                self.cacheManager.loadImage(from: imageURL) { result in
////                    switch result {
////                    case .success(let cachedImage):
////                        XCTAssertEqual(cachedImage, image)
////                        expectation.fulfill()
////                    case .failure(let error):
////                        XCTFail("Failed to load image from cache: \(error.localizedDescription)")
////                    }
////                }
////
////            case .failure(let error):
////                XCTFail("Failed to load image from network: \(error.localizedDescription)")
////            }
////        }
////        //        cacheManager.loadImage(from: imageURL) { [weak self] result in
////        //            switch result {
////        //            case .success(let image):
////        //                XCTAssertNotNil(image)
////        //
////        //                // Second request - Image should be loaded from cache
////        //                self.cacheManager.loadImage(from: imageURL) { result in
////        //                    switch result {
////        //                    case .success(let cachedImage):
////        //                        XCTAssertEqual(cachedImage, image)
////        //                        expectation.fulfill()
////        //                    case .failure(let error):
////        //                        XCTFail("Failed to load image from cache: \(error.localizedDescription)")
////        //                    }
////        //                }
////        //
////        //            case .failure(let error):
////        //                XCTFail("Failed to load image from network: \(error.localizedDescription)")
////        //            }
////        //        }
////
////        wait(for: [expectation], timeout: 5.0)
////    }
//}
