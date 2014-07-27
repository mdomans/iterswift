//
//  itertoolsTests.swift
//  itertoolsTests
//
//  Created by mdomans on 26/07/14.
//  Copyright (c) 2014 mdomans. All rights reserved.
//

import UIKit
import XCTest

class itertoolsTests: XCTestCase {

    
    func testCycle () {
//        for x  in cycle(["a", "b"]) {
//            println(x)
//        }
    }
    
    func testZip () {
        for x in izip(["a", "b"], ["c","d"], ["e", "f"]) {
            println(x)
        }
    }
    
    func testChain() {
        for x in chain(["a", "b"], ["c"], ["d"]) {
            println(x)
        }
    }
    
}
