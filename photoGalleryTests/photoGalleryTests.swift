//
//  photoGalleryTests.swift
//  photoGalleryTests
//
//  Created by Екатерина Иванова on 05.12.2024.
//

import XCTest
@testable import photoGallery

//to check loading data
class APIServiceTests: XCTestCase {

    var apiService: GetPhotosService!

    override func setUp() {
        super.setUp()
        apiService = GetPhotosService(networkManager: NetworkManager.shared)
    }

    override func tearDown() {
        apiService = nil
        super.tearDown()
    }

    func testFetchDataFromAPI() {
        let expectation = self.expectation(description: "Fetching data from API")
        
        apiService.getPhotos() { (result) in
            switch result {
            case .success(let data):
                XCTAssertFalse(data.isEmpty, "Data should not be empty")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
