//
//  StorytelChallengeTests.swift
//  StorytelChallengeTests
//
//  Created by Jonathan on 2019. 05. 22..
//  Copyright © 2019. Jonathan. All rights reserved.
//

import XCTest
@testable import StorytelChallenge

class StorytelChallengeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBookCollectionViewController() {
        let vc = BookCollectionViewController()
        XCTAssertEqual(vc.nextPage, "1")
        XCTAssertEqual(vc.footerId, "footerId")
        XCTAssertEqual(vc.headerId, "headerId")
        XCTAssertEqual(vc.padding, 16)
        XCTAssertEqual(vc.inFetchingMode, false)
        vc.loadPage(from: vc.nextPage)
        XCTAssertEqual(vc.inFetchingMode, true)
    }

}
