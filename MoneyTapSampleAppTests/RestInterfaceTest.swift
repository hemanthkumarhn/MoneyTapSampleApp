//
//  RestInterfaceTest.swift
//  MoneyTapSampleAppTests
//
//  Created by hemanth kumar on 22/08/18.
//  Copyright © 2018 MoneyTapSample. All rights reserved.
//

import XCTest
@testable import MoneyTapSampleApp

class RestInterfaceTest: XCTestCase {

    var interface:RestInterface!
  //  var searchm:searchModel!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testsearchCallExamplewithEmptyString() {
        //let _: Bool
        interface.searchCall(searchText: "", completionHandler:{ searchm, boolvar in
        })

    }
    func testsearchCallExamplewithoutValidData() {
        //let _: Bool
        interface.searchCall(searchText: "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=&gpslimit=10", completionHandler:{ searchm, boolvar in
        })

    }
    func testsearchCallExampleValidData() {
        let value: String! = "sachin_tend"
        interface.searchCall(searchText: value , completionHandler:{ searchm, boolvar in

        })

    }
    
}
