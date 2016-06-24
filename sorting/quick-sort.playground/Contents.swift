//: Playground - noun: a place where people can play

import UIKit

func quickSort<T: Comparable>(inout inputArray: [T]) {

  quickSort(&inputArray, leftPartition: 0, rightPartition: inputArray.count - 1)

}

func quickSort<T: Comparable>(inout inputArray: [T],
               leftPartition: Int, rightPartition: Int) {
  if ( rightPartition - leftPartition <= 1 ) { return }

  var leftIterator = leftPartition
  var rightIterator = rightPartition - 1

  let pivotIndex = (rightPartition - leftPartition) >> 1
  let pivotValue = inputArray[pivotIndex]

  print("pivot index: \(pivotIndex), pivot value: \(pivotValue)")

  swap(&inputArray[pivotIndex], &inputArray[rightPartition])

  while leftIterator < rightIterator {
    while inputArray[leftIterator] < pivotValue {
      if leftIterator >= pivotIndex { break }
      leftIterator += 1
      //print("Left Iterator: \(leftIterator)")
    }
    while inputArray[rightIterator] >= pivotValue {
      if leftIterator >= rightIterator { break }
      rightIterator -= 1
      //print("Right iterator: \(rightIterator)")
    }
    if leftIterator != rightIterator {
      swap(&inputArray[leftIterator], &inputArray[rightIterator])
    }
  }
  if inputArray[leftIterator] > pivotValue {
    swap(&inputArray[leftIterator], &inputArray[rightPartition])
  }

  print("After partitioning array: \(inputArray)")
  quickSort(&inputArray,
            leftPartition: leftPartition, rightPartition: leftIterator)
  quickSort(&inputArray,
            leftPartition: leftIterator+1, rightPartition: rightPartition)

}

extension CollectionType {
  /// Return a copy of `self` with its elements shuffled
  func shuffle() -> [Generator.Element] {
    var list = Array(self)
    list.shuffleInPlace()
    return list
  }
}

extension MutableCollectionType where Index == Int {
  /// Shuffle the elements of `self` in-place. Using Fisher-Yates method
  mutating func shuffleInPlace() {
    // empty and single-element collections don't shuffle
    if count < 2 { return }

    for i in 0..<count - 1 {
      let j = Int(arc4random_uniform(UInt32(count - i))) + i
      guard i != j else { continue }
      swap(&self[i], &self[j])
    }
  }
}

var testArray : [Int] = [1,2,2,3,4,4,5,6,6,7,8,9,9]
var shuffledArray = testArray.shuffle()
print("Shuffled array: \(shuffledArray)")
quickSort(&shuffledArray)
print("\(shuffledArray)")



