//
//  ImageCacheManagerTests.swift
//  SquareCodeChallengeTests
//
//  Created by Khadija Daruwala on 2023-07-18.
//

import XCTest

import XCTest
@testable import SquareCodeChallenge

final class ImageCacheManagerTests: XCTestCase {
    var imageCacheManager: ImageCacheManager!
    
    override func setUp() {
        super.setUp()
        imageCacheManager = ImageCacheManager.shared
    }
    
    override func tearDown() {
        imageCacheManager = nil
        super.tearDown()
    }
    
    func testLoadImageFromURL() {
        let expectation = XCTestExpectation(description: "Load image from URL")
        let imageURL = "https://s3.amazonaws.com/sq-mobile-interview/photos/5095a907-abc9-4734-8d1e-0eeb2506bfa8/large.jpg"
        
        imageCacheManager.loadImage(from: imageURL) { result in
            switch result {
            case .success(let image):
                XCTAssertNotNil(image, "Loaded image should not be nil")
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail("Failed to load image: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}


//final class ImageCacheManagerTests: XCTestCase {
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
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}
