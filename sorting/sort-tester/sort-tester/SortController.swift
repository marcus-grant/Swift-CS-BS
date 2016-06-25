//
//  SortController.swift
//  sort-tester
//
//  Created by Marcus Grant on 6/24/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//

import Foundation

class SortController: NSObject {

  func bubbleSort<T: Comparable>(inout inputArray: [T]) {
    for outerIndex in 0..<inputArray.count - 1 {
      for innerIndex in outerIndex + 1 ..< inputArray.count {
        if inputArray[outerIndex] > inputArray[innerIndex] {
          swap(&inputArray[outerIndex], &inputArray[innerIndex])
        }
      }
    }
  }

  func quickSort<T: Comparable>(inout inputArray: [T]) {

    quickSort(&inputArray, leftPartition: 0, rightPartition: inputArray.count - 1)

  }

  func quickSortDebug<T: Comparable>(inout inputArray: [T]) {
    quickSortDebug(&inputArray, leftPartition: 0, rightPartition: inputArray.count - 1)
  }

  func quickSortDebug<T: Comparable>(inout inputArray: [T],
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
    print("                             " + arrayStringWithIndex(inputArray))

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
        print("                           " + arrayStringWithIndex(inputArray))
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
    print("                          \(arrayStringWithIndex(inputArray))")
    quickSort(&inputArray,
              leftPartition: leftPartition, rightPartition: leftIterator)
    quickSort(&inputArray,
              leftPartition: leftIterator+1, rightPartition: rightPartition)
    
  }


  func quickSort<T: Comparable>(inout inputArray: [T],
                 leftPartition: Int, rightPartition: Int) {
    if ( rightPartition - leftPartition <= 1 ) { return }

    var leftIterator = leftPartition
    var rightIterator = rightPartition - 1

    let pivotIndex = (rightPartition - leftPartition) >> 1 + leftPartition
    let pivotValue = inputArray[pivotIndex]

    //let pivotIndex = rightPartition
    //let pivotValue = inputArray[pivotIndex]

    swap(&inputArray[pivotIndex], &inputArray[rightPartition])

    while leftIterator < rightIterator {
      while inputArray[leftIterator] < pivotValue {
        if leftIterator >= rightIterator { break }
        leftIterator += 1
      }
      while inputArray[rightIterator] >= pivotValue {
        if leftIterator >= rightIterator { break }
        rightIterator -= 1
      }
      if leftIterator != rightIterator {
        swap(&inputArray[leftIterator], &inputArray[rightIterator])
      }
    }
    if inputArray[leftIterator] > pivotValue {
      swap(&inputArray[leftIterator], &inputArray[rightPartition])
      // this is needed because on the last partition there exists the possibility that a larger number gets skipped over, comment it out to find out more
      if (inputArray[leftIterator+1] > inputArray[rightPartition]) {
        swap(&inputArray[leftIterator+1], &inputArray[rightPartition])
      }
    }
    quickSort(&inputArray,
              leftPartition: leftPartition, rightPartition: leftIterator)
    quickSort(&inputArray,
              leftPartition: leftIterator+1, rightPartition: rightPartition)

  }

  func shuffleInPlace<T>(inout inputArray: [T]) {
    let size = inputArray.count
    if size < 2 { return }

    for i in 0 ..< size - 1 {
      let j = Int(arc4random_uniform(UInt32(size - i))) + i
      guard i != j else { continue }
      swap(&inputArray[i], &inputArray[j])
    }
  }

  func arrayStringWithIndex<T>(inputArray: [T]) -> String {
    let arrayString = String(inputArray)
    var indexString: String = "["
    var charCount = 0
    var indexValue = 0
    //var charBuffer = [Character]()
    for currentChar in arrayString.characters {
      switch currentChar {
      case "[":
        break
      case ",","]":
        let indexDigits = Int(indexValue/10) + 1
        var whiteSpaceCount = charCount - indexDigits
        while whiteSpaceCount > 0 {
          indexString.append(Character(" "))
          whiteSpaceCount -= 1
        }
        indexString +=  "\(indexValue)"
        if currentChar == "," { indexString += "," }
        indexValue += 1
        charCount = 0
        if indexString.characters.count >= 60 { /* add newline logic for both here */}
      default:
        charCount += 1
      }
    }
    indexString.append(Character("]"))
    return indexString
  }

  func createTestArrayWith(numElements: UInt, minValue: Int, maxValue: Int) -> [Int] {
    var currentArrayIndex: UInt = 0
    var returnArray = [Int()]
    while currentArrayIndex < numElements {
      let randomInt = Int(arc4random_uniform(UInt32(maxValue - minValue + 1))) + minValue
      returnArray.append(randomInt)
      currentArrayIndex += 1
    }
    return returnArray
  }

}

