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
