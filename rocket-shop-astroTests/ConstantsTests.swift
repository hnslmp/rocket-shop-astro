//
//  ConstantsTests.swift
//  rocket-shop-astroTests
//
//  Created by Hansel Matthew on 07/01/24.
//

import XCTest
@testable import rocket_shop_astro

final class ConstantsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testProductRequestEndpoint() throws {
        XCTAssertEqual(Constants.baseApi, "https://fakestoreapi.com/", "Base API url is wrong")
    }
}
