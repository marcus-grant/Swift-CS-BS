//
//  SortController.swift
//  sort-tester
//
//  Created by Marcus Grant on 6/24/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//

import Foundation

class SortController: NSObject {

  // MARK: BubbleSort
  ///////////////////////////////////////////////////////////////////////////////////////

  func bubbleSort<T: Comparable>(inout inputArray: [T]) {
    for outerIndex in 0..<inputArray.count - 1 {
      for innerIndex in outerIndex + 1 ..< inputArray.count {
        if inputArray[outerIndex] > inputArray[innerIndex] {
          swap(&inputArray[outerIndex], &inputArray[innerIndex])
        }
      }
    }
  }

  func bubbleSortWithStats<T: Comparable>(inout inputArray: [T])
    -> (compares: Int, arrayAccesses: Int, time: Int) {
      let startTime = NSDate()
      var comparisons = 0
      var arrayAccesses = 0
    for outerIndex in 0..<inputArray.count - 1 {
      for innerIndex in outerIndex + 1 ..< inputArray.count {
        if inputArray[outerIndex] > inputArray[innerIndex] {
          swap(&inputArray[outerIndex], &inputArray[innerIndex])
          arrayAccesses += 1
        }
        comparisons += 1
      }
    }
      return (comparisons, arrayAccesses, Int(-1000 * startTime.timeIntervalSinceNow))
  }

  // MARK: Combsort
  ///////////////////////////////////////////////////////////////////////////////////////

  // The default Comb-sort, performed with scale factor of 1.3, this is usually optimal
  func combSort<T: Comparable>(inout inputArray: [T]) {
    combSort(&inputArray, gapScaleFactor: 1.3)
  }

  func combSortWithDebug<T: Comparable>(inout inputArray: [T], gapScaleFactor: Double) {
    let size = inputArray.count
    var leftIndex = 0
    var rightIndex = size - 1
    var currentGap = rightIndex - leftIndex
    var swapped = true

    // The outer loop is used to keep reducing the currentGap for the inner loop, or to
    // to keep it going till no swaps were made in the previous iteration, which is 
    // necessary for the final phase of the sort. (bubble sort essentially)
    while currentGap != 1 || swapped {
      print("Current gap: \(currentGap), swapped: \(swapped)")

      leftIndex = 0
      rightIndex = leftIndex + currentGap

      // Initialize the swapped flag, since it's used in inner loop
      swapped = false

      // Inner loop checks two indeces referencing values, swaps if necessary, and 
      // changes the swap flag if a swap was performed, to keep the loops going till 
      // the entire array is sorted
      while rightIndex < size {
        if inputArray[leftIndex] > inputArray[rightIndex] {
          print("Swapped \(inputArray[leftIndex]) with \(inputArray[rightIndex])")
          swap(&inputArray[leftIndex], &inputArray[rightIndex])
          print("After swap the array is: \(inputArray)")
          swapped = true
        }
        leftIndex += 1
        rightIndex += 1
      }
      // With every outer loop iteration we need to either reduce gap by scaling factor
      // OR keep it at 1 for the last phase of the sort
      if currentGap < 1 {
        currentGap = 1
      } else {
        currentGap = Int(Double(currentGap)/gapScaleFactor)
      }
    }
  }

  func combSort<T: Comparable>(inout inputArray: [T], gapScaleFactor: Double) {
    let size = inputArray.count
    var leftIndex = 0
    var rightIndex = size - 1
    var currentGap = rightIndex - leftIndex
    var swapped = true

    // The outer loop is used to keep reducing the currentGap for the inner loop, or to
    // to keep it going till no swaps were made in the previous iteration, which is
    // necessary for the final phase of the sort. (bubble sort essentially)
    while currentGap != 1 || swapped {
      leftIndex = 0
      rightIndex = leftIndex + currentGap

      // Initialize the swapped flag, since it's used in inner loop
      swapped = false

      // Inner loop checks two indeces referencing values, swaps if necessary, and
      // changes the swap flag if a swap was performed, to keep the loops going till
      // the entire array is sorted
      while rightIndex < size {
        if inputArray[leftIndex] > inputArray[rightIndex] {
          swap(&inputArray[leftIndex], &inputArray[rightIndex])
          swapped = true
        }
        leftIndex += 1
        rightIndex += 1
      }
      // With every outer loop iteration we need to either reduce gap by scaling factor
      // OR keep it at 1 for the last phase of the sort
      if currentGap < 1 {
        currentGap = 1
      } else {
        currentGap = Int(Double(currentGap)/gapScaleFactor)
      }
    }
  }

  func combSortWithStats<T: Comparable>(inout inputArray: [T], gapScaleFactor: Double)
    -> (compares: Int, arrayAccesses: Int, time: Int) {

      let startTime = NSDate()
      var comparisons = 0
      var arrayAccesses = 0
      let size = inputArray.count
      var leftIndex = 0
      var rightIndex = size - 1
      var currentGap = rightIndex - leftIndex
      var swapped = true

      // The outer loop is used to keep reducing the currentGap for the inner loop, or to
      // to keep it going till no swaps were made in the previous iteration, which is
      // necessary for the final phase of the sort. (bubble sort essentially)
      while currentGap != 1 || swapped {
        leftIndex = 0
        rightIndex = leftIndex + currentGap

        // Initialize the swapped flag, since it's used in inner loop
        swapped = false

        // Inner loop checks two indeces referencing values, swaps if necessary, and
        // changes the swap flag if a swap was performed, to keep the loops going till
        // the entire array is sorted
        while rightIndex < size {
          if inputArray[leftIndex] > inputArray[rightIndex] {
            swap(&inputArray[leftIndex], &inputArray[rightIndex])
            arrayAccesses += 4
            swapped = true
          }
          leftIndex += 1
          rightIndex += 1
          comparisons += 1
        }
        // With every outer loop iteration we need to either reduce gap by scaling factor
        // OR keep it at 1 for the last phase of the sort
        if currentGap < 1 {
          currentGap = 1
        } else {
          currentGap = Int(Double(currentGap)/gapScaleFactor)
        }
      }
      return (comparisons, arrayAccesses, Int(-1000 * startTime.timeIntervalSinceNow))
  }

  // MARK: QuickSort
  ///////////////////////////////////////////////////////////////////////////////////////

  func quickSort<T: Comparable>(inout inputArray: [T]) {

    quickSort(&inputArray, leftPartition: 0, rightPartition: inputArray.count - 1)

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

  func quickSortWithDebug<T: Comparable>(inout inputArray: [T]) {
    quickSortWithDebug(&inputArray, leftPartition: 0, rightPartition: inputArray.count - 1)
  }

  func quickSortWithDebug<T: Comparable>(inout inputArray: [T],
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

  func quickSortWithStats<T: Comparable>(inout inputArray: [T])
    -> (comparisons: Int, arrayAccesses: Int, time: Int) {
      let startTime = NSDate()
      let end = inputArray.count - 1
      let stats =
        quickSortWithStatsHelper(&inputArray, leftPartition: 0, rightPartition: end)
      let comparisons = stats.comparisons
      let arrayAccessess = stats.arrayAccesses
      return (comparisons, arrayAccessess,Int(-1000*startTime.timeIntervalSinceNow))
  }

  func quickSortWithStatsHelper<T: Comparable>(inout inputArray: [T],
                          leftPartition: Int, rightPartition: Int)
    -> (comparisons: Int, arrayAccesses: Int) {
    var comparisons = 0
    var arrayAccesses = 0
    if ( rightPartition - leftPartition <= 1 ) { return (comparisons, arrayAccesses) }

    var leftIterator = leftPartition
    var rightIterator = rightPartition - 1

    let pivotIndex = (rightPartition - leftPartition) >> 1 + leftPartition
    let pivotValue = inputArray[pivotIndex]

    //let pivotIndex = rightPartition
    //let pivotValue = inputArray[pivotIndex]

    swap(&inputArray[pivotIndex], &inputArray[rightPartition])
    arrayAccesses += 4

    while leftIterator < rightIterator {
      while inputArray[leftIterator] < pivotValue {
        comparisons += 1
        if leftIterator >= rightIterator { break }
        leftIterator += 1
      }
      while inputArray[rightIterator] >= pivotValue {
        comparisons += 1
        if leftIterator >= rightIterator { break }
        rightIterator -= 1
      }
      if leftIterator != rightIterator {
        swap(&inputArray[leftIterator], &inputArray[rightIterator])
        arrayAccesses += 4
      }
    }
    if inputArray[leftIterator] > pivotValue {
      comparisons += 1
      swap(&inputArray[leftIterator], &inputArray[rightPartition])
      arrayAccesses += 4
      // this is needed because on the last partition there exists the possibility that a larger number gets skipped over, comment it out to find out more
      comparisons += 1
      if (inputArray[leftIterator+1] > inputArray[rightPartition]) {
        swap(&inputArray[leftIterator+1], &inputArray[rightPartition])
        arrayAccesses += 4
      }
    }
    let leftStats = quickSortWithStatsHelper(&inputArray, leftPartition: leftPartition, rightPartition: leftIterator)
    let rightStats = quickSortWithStatsHelper(&inputArray, leftPartition: leftIterator+1, rightPartition: rightPartition)

    comparisons += leftStats.comparisons + rightStats.comparisons
    arrayAccesses += leftStats.arrayAccesses + rightStats.arrayAccesses

    return (comparisons, arrayAccesses)
  }



  // MARK: Helper Functions

  func shuffleInPlace<T>(inout inputArray: [T]) {
    let size = inputArray.count
    if size < 2 { return }

    for i in 0 ..< size - 1 {
      let j = Int(arc4random_uniform(UInt32(size - i))) + i
      guard i != j else { continue }
      swap(&inputArray[i], &inputArray[j])
    }
  }


  // MARK: Testing

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

  func testCombSortWithInts(trials: Int, size: Int, gapScale: Double, minValue: Int, maxValue: Int)
    -> (minTime: Int, avgTime: Int, maxTime: Int) {
    var minTime = 0
    var sumTime = 0
    var maxTime = 0
    // outerloop for each trial sort
    var currentTrial = 0
    while currentTrial < trials {
      var testArray =
        createTestArrayWith(UInt(size), minValue: minValue, maxValue: maxValue)
      let stats = combSortWithStats(&testArray, gapScaleFactor: gapScale)
      sumTime += stats.time
      if minTime > stats.time { minTime = stats.time }
      if maxTime < stats.time { maxTime = stats.time }
      currentTrial += 1
    }
    let avgTime = Int(sumTime/trials)
    return (minTime, avgTime, maxTime)
  }

  func testCombSortWithGapSweep(trials: Int, size: Int, minGap: Double, maxGap: Double, sweepRate: Double)
    -> [Int] {
      var resultsArray = [Int]()
      var currentGap = minGap
      while currentGap <= maxGap {
        let stats = testCombSortWithInts(trials, size: size, gapScale: currentGap, minValue: 0, maxValue: 99)
        resultsArray.append(stats.avgTime)
        currentGap += sweepRate
      }
      return resultsArray
  }


}

