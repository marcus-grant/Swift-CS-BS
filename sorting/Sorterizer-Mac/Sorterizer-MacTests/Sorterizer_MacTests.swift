//
//  Sorterizer_MacTests.swift
//  Sorterizer-MacTests
//
//  Created by Marcus Grant on 6/29/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//

import XCTest
@testable import Sorterizer_Mac

class Sorterizer_MacTests: XCTestCase {
  var sorter = SortController()
  var array = [Int]()

  override func setUp() {
    array = sorter.createTestArray(100, minValue: 0, maxValue: 99)
    //array = [5,4,3,2,1]
    super.setUp()
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testCalculateStats() {
    let testData = [1.0,2.0,3.0,4.0,5.0]
    let expectedMin = 1.0
    let expectedMax = 5.0
    let expectedMean = 3.0
    let expectedDev = 1.41
    let testResult = sorter.calculateStats(testData)
    XCTAssert(testResult.min == expectedMin, "Minimum correct!")
  }

  func testQuickSort() {
    sorter.quickSort(&array)
    print("array: \(array)")
    XCTAssert(verifySort(array, ascending: true))
  }




  func testExample() {
    XCTAssert(true)
  }

  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measureBlock {
      // Put the code you want to measure the time of here.
    }
  }

  func verifySort<T: Comparable>(collection: [T], ascending: Bool) -> Bool{
    if ascending {
      for index in 1 ..< collection.count {
        if collection[index-1] > collection[index] { return false }
      }
    } else {
      for index in 1 ..< collection.count {
        if collection[index-1] < collection[index] { return false }
      }
    }
    return true
  }
}
