//
//  rocket_shop_astroTests.swift
//  rocket-shop-astroTests
//
//  Created by Hansel Matthew on 07/01/24.
//

import XCTest
@testable import rocket_shop_astro

final class ServiceTests: XCTestCase {
    
    let service = Service()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRequestProducts() {
        service.requestProducts { result in
            switch result {
            case .success(let productsList):
                XCTAssertNotNil(productsList, "Products list should not be nil")
            case .failure(let error):
                XCTFail("Request should not fail. Error: \(error.localizedDescription)")
            }
        }
    }
}
