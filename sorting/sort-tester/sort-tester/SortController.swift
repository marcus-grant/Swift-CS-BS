//
//  SortController.swift
//  sort-tester
//
//  Created by Marcus Grant on 6/24/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//

import Foundation

//TODO: Fix array access counter, it's not accurate for most funcs that use them
//TODO: Fix merge-sort
//TODO: Add merge-sort with linked lists
//TODO: Make an evaluation func that takes a closure for which sort to get stats for
//TODO: Add closure support (and enum?) to specify the variant and type of sort
//TODO: Add Selection and Insertion sort
//TODO: Add heapsort
//TODO: Add timsort
//TODO: Add

class SortController: NSObject {

  private var randomState = UInt32(NSDate().timeIntervalSinceNow)

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

  ////////////////////////////////////////////////////////////////////////////////////////
  // MARK: - QuickSort Helper Methods
  ////////////////////////////////////////////////////////////////////////////////////////


  // The cheapest (time wise) improvement to quick-sort pivot selection is to just pick
  // the middle index
  func middleIndex<T>(inout array: [T]) -> Int {
    return array.count >> 1
  }
  // One way to improve quick-sort performance is called the "Median Of 3" method.
  // Basically you compare the values of the front, back, and middle of the array
  // for the median value. This reduces the odds of a particularly high, or low
  // pivot value, which slows down the sort since it creates smaller divisions
  // This is a really cheap way to improve pivot collection.
  // In smaller arrays, it might be too much overhead to be of value
  func medianOf3Pivot<T: Comparable>(array: [T]) -> Int {
    var indeces = [0, array.count >> 1, array.count - 1]
    // sort this array of the three indeces by their associated collection value
    if array[indeces[0]] > array[indeces[2]] {
      swap(&indeces[0], &indeces[2])
    }
    if array[indeces[0]] > array[indeces[1]] {
      swap(&indeces[0], &indeces[1])
    }
    if array[indeces[1]] > array[indeces[2]] {
      swap(&indeces[1], &indeces[2])
    }
    // Now the indeces are sorted by their associated value in the collection
    // The median of three index is now inside indeces[1]
    return indeces[1]
  }

  // Another pivot selection strategy to improve sort times is to pick a random pivot
  // However arc4random, though a decent random number generator, might be too slow
  // to offer any noticable sort time improvements, it might even make it worse
  func arc4randomPivot<T>(inout array: [T]) -> Int {
    return Int(arc4random_uniform(UInt32(array.count)))
  }
  // This returns a randomized pivot using a faster random number function than arc4.
  // XOR shifts are less predictable than arc4, but predictability isn't important in
  // picking "random" pivots; the time it takes to actually come up with a random pivot
  // will have a significantly largre impact on overall sort performance.
  // Not counting function calls of helpers, randomPivot() should only take 20 cycles
  func randomPivot(arraySize: Int) -> Int {
    updateXORShiftState()
    return Int(roundedDownBitMask(UInt32(arraySize)) & randomState)
  }

  // Linear Feedback Shift Registers are a fast way to come up with unpredictable,
  // and relatively uniform random numbers MUCH faster than arc4random_uniform
  private func updateLFSRState(){
    let feedbackBit = (randomState ^ (randomState >> 2) ^ (randomState >> 3) ^
      (randomState >> 5)) & 1
    randomState = (randomState >> 1) | (feedbackBit << 15)
  }

  // Using the current time in seconds since epoch time as the starting random
  // state, a XOR shift is used to come up with a fast and fairly uniform random
  // next state, which is represented as an unsigned 32 bit number.
  // EVEN FASTER than LFSR but sacrifices unpredictability, which isn't important
  // in a sorting method
  private func updateXORShiftState() {
    randomState ^= randomState >> 12
    randomState ^= randomState << 25
    randomState ^= randomState >> 27
  }

  // Returns a bitmask of the bit positions lower than the number given.
  // Gets used as a faster version of the modulo, but with even worse modulo bias
  // The bit manipulation used is to find the nearest power of 2 number to the
  // given number, but normally at the end you'd add 1 to x, without it we get the
  // correct bit mask to reduce a numbers range with worst case precision of n/2
  private func roundedDownBitMask (number: UInt32) -> UInt32 {
    var x = number
    x -= 1
    x |= x >> 1
    x |= x >> 2
    x |= x >> 4
    x |= x >> 8
    x |= x >> 16
    return x
  }

  //////////////////////////////////////////////////////////////////////////////////////
  // MARK: - Merge
  //////////////////////////////////////////////////////////////////////////////////////

  func mergeSort<T: Comparable>(inout inputArray: [T]) {

    // The exit condition for when recursive calls of self split sub-arrays to 1
    if inputArray.count <= 1 {
      return
    }

    // Split the current recursion's array into a left and right array
    let middleIndex = inputArray.count / 2
    var leftArray = [T]()
    var rightArray = [T]()

    for leftIndex in 0..<middleIndex {
      leftArray.append(inputArray[leftIndex])
    }

    for rightIndex in middleIndex..<inputArray.count {
      rightArray.append(inputArray[rightIndex])
    }

    // Recursively calling mergeSort() with the left and right arrays will keep splitting
    // the array until there's only sub-arrays with 2 or 3 elements
    mergeSort(&leftArray)
    mergeSort(&rightArray)

    // Once all the arrays are split as much as possible the recursion reverses by calling
    // merge() to merge the arrays in order, until the recursion ends only 2 arrays merge
    inputArray = merge(&leftArray, rightArray: &rightArray)

  }

  func merge<T: Comparable>(inout leftArray: [T], inout rightArray:[T]) -> [T]{

    // Initialize the array that will be merged and sorted
    var sortedArray = [T]()

    // Merge by constantly checking current index of sub-arrays
    while (!leftArray.isEmpty && !rightArray.isEmpty)
    {
      // Take first element of left and right arrays and compare for smallest value
      // The first element of each array will be the smallest of that array, so add that
      // element to the sortedArray, and remove it from the array with the smaller
      if leftArray[0] <= rightArray[0] {
        sortedArray.append(leftArray[0])
        leftArray.removeAtIndex(0)
      } else {
        sortedArray.append(rightArray[0])
        rightArray.removeAtIndex(0)
      }

      // On many occasions either the left or right array will be emptied before the other
      // If that's the case simply append the remaining array to the sorted array
      while !leftArray.isEmpty {
        sortedArray.append(leftArray[0])
        leftArray.removeAtIndex(0)
      }

      while !rightArray.isEmpty {
        sortedArray.append(rightArray[0])
        rightArray.removeAtIndex(0)
      }
      
    }
    return sortedArray
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

  func isSorted<T: Comparable>(array: [T], ascending: Bool) -> Bool {
    if ascending {
      for index in 1 ..< array.count {
        if array[index - 1] > array[index] { return false }
      }
    } else {
      for index in 1 ..< array.count {
        if array[index - 1] < array[index] { return false }
      }
    }
    return true
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
  //MARK: - Stats funcs
  func getStats(data: [Double])
    -> (min: Double, max: Double, mean: Double, stdDev: Double) {
      let samples = Double(data.count)
      let min = data.minElement()!
      let max = data.maxElement()!
      let mean = data.reduce(0){$0 + $1} / samples // sum data with reduce, then divide
      // order of operations for stdDev:
      // 1. For each element of data; take difference from mean and square result (map())
      // 2. Sum all results from previous ( reduce() )
      // 3. Divide by array size of data (samples)
      // 4. Finally take square root of it all ( sqrt() )
      let stdDev =
        sqrt(data.map{ pow($0 - mean, 2) }.reduce(0, combine: { $0 + $1 }) / samples)
      return (min, max, mean, stdDev)
  }
}



// TODO: make these work later so stats funcs can be generic
// Protocol with extensions to define a NumericType
// Constrains data type to only declared numerical types
protocol NumericType {}
extension Float:  NumericType {}
extension Double: NumericType {}
extension Int:    NumericType {}



