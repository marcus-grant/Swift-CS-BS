//
//  SortController.swift
//  sort-tester
//
//  Created by Marcus Grant on 6/24/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//

import Foundation

class SortController: NSObject {

  func quickSort<T: Comparable>(inout inputArray: [T]) {

    quickSort(&inputArray, leftPartition: 0, rightPartition: inputArray.count - 1)

  }

  func quickSort<T: Comparable>(inout inputArray: [T],
                 leftPartition: Int, rightPartition: Int) {
    if ( rightPartition - leftPartition <= 1 ) { return }

    var leftIterator = leftPartition
    var rightIterator = rightPartition - 1

    print("left iterator starting at: \(leftIterator), right: \(rightIterator)")

    let pivotIndex = (rightPartition - leftPartition) >> 1 + leftPartition
    let pivotValue = inputArray[pivotIndex]

    //let pivotIndex = rightPartition
    //let pivotValue = inputArray[pivotIndex]

    print("pivot index: \(pivotIndex), pivot value: \(pivotValue)")

    swap(&inputArray[pivotIndex], &inputArray[rightPartition])

    print("pivot swapped to end, array: \(inputArray)")
    print("                             [0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12]")

    while leftIterator < rightIterator {
      while inputArray[leftIterator] < pivotValue {
        if leftIterator >= rightIterator { break }
        leftIterator += 1
        print("Left Iterator: \(leftIterator)")
      }
      while inputArray[rightIterator] >= pivotValue {
        if leftIterator >= rightIterator { break }
        rightIterator -= 1
        print("Right iterator: \(rightIterator)")
      }
      print("iterators stopped at (l,r): \(leftIterator), \(rightIterator)")
      print("iterators point to values (l,r):\(inputArray[leftIterator]),\(inputArray[rightIterator])")
      if leftIterator != rightIterator {
        swap(&inputArray[leftIterator], &inputArray[rightIterator])
        print("Swap completed, new array: \(inputArray)")
        print("                           [0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12]")
      }
    }
    if inputArray[leftIterator] > pivotValue {
      swap(&inputArray[leftIterator], &inputArray[rightPartition])
      // this is needed because on the last partition there exists the possibility that a larger number gets skipped over, comment it out to find out more
      if (inputArray[leftIterator+1] > inputArray[rightPartition]) {
        swap(&inputArray[leftIterator+1], &inputArray[rightPartition])
      }
    }

    print("After partitioning array: \(inputArray)")
    print("                          [0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12]")
    quickSort(&inputArray,
              leftPartition: leftPartition, rightPartition: leftIterator)
    quickSort(&inputArray,
              leftPartition: leftIterator+1, rightPartition: rightPartition)

  }

  func shuffleInPlace<T>(inout inputArray: [T])
  {
    let size = inputArray.count
    if size < 2 { return }

    for i in 0 ..< size - 1 {
      let j = Int(arc4random_uniform(UInt32(size - i))) + i
      guard i != j else { continue }
      swap(&inputArray[i], &inputArray[j])
    }
  }

}

