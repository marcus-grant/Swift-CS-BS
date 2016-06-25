//: Playground - noun: a place where people can play

import Cocoa

// define unsorted array in question
var orderedArr: [Int] = [1,2,3,4,5,6,7,8,9]

// shuffle the array with array extensions
func shuffleInPlace<T>(inout inputArray: [T]) {
  let size = inputArray.count
  if size < 2 { return }

  for i in 0 ..< size - 1 {
    let j = Int(arc4random_uniform(UInt32(size - i))) + i
    guard i != j else { continue }
    swap(&inputArray[i], &inputArray[j])
  }
}

// array before being sorted
print (orderedArr)
let arr = [Int(shuffleInPlace(&orderedArr))]

// lets merge-sort by hand so the method is more clear
// first split the array till each element has it's own sub-set of size 1
// any set of size 1 is always sorted

let a = 5; let b = 1; let c = 6; let d = 7; let e = 4
let f = 2; let g = 9; let h = 3; let i = 8

// now continue to merge these sub-arrays into larger ones, from left to right, in order
// first create temporary sub array
var a_and_b: [Int], c_and_d: [Int], e_and_f: [Int], g_and_h : [Int]

if (a < b ) {
  a_and_b = [a]
  a_and_b.append(b)
  print ("b > a .")
} else {
  a_and_b = [b]
  a_and_b.append(a)
  print ("a > b .")
}; if (c < d ) {
  c_and_d = [c]
  c_and_d.append(d)
  print ("d > c .")
} else {
  c_and_d = [d]
  c_and_d.append(c)
  print ("c > d .")
}; if ( e < f ) {
  e_and_f = [e]
  e_and_f.append(f)
  print ("f > e .")
} else {
  e_and_f = [f]
  e_and_f.append(e)
  print ("e > f .")
}; if ( g < h ) {
  g_and_h = [g]
  g_and_h.append(h)
  print ("h > g .")
} else {
  g_and_h = [h]
  g_and_h.append(g)
  print ("g > h .")
}

print ("Here are the five sub-arrays:")
print ("\(a_and_b) \(c_and_d) \(e_and_f) \(g_and_h) \(i)")

// now lets merge the 5 sub-arrays into 3, in order

var a_to_d = [Int](count: 4, repeatedValue: 0)
var e_to_h = [Int](count: 4, repeatedValue: 0)
var leftCursor: Int = 0
var rightCursor: Int = 0

// MARK: change to while, with top condition as exit condition
// ALSO revise the logic so its cleaner
for index in 0 ..< a_and_b.count + c_and_d.count {
  if (leftCursor >= a_and_b.count && rightCursor >= c_and_d.count ) {
    break
  } else if leftCursor >= a_and_b.count{
    a_to_d[index] = c_and_d[rightCursor]
    rightCursor += 1
  } else if rightCursor >= c_and_d.count {
    a_to_d[index] = a_and_b[leftCursor]
    leftCursor += 1
  } else if (a_and_b[leftCursor] > c_and_d[rightCursor]) {
    a_to_d[index] = c_and_d[rightCursor]
    rightCursor += 1
  } else {
    a_to_d[index] = a_and_b[leftCursor]
    leftCursor += 1
  }
}

// now sub array a_to_d is sorted and merged with a_and_b and c_and_d
print ("Sub-array \"a_to_d\" is now sorted, here is it's contents: \(a_to_d)")

// MARK: repeat for e_to_h
leftCursor = 0
rightCursor = 0
for index in 0 ..< e_and_f.count + g_and_h.count {
  if (leftCursor >= e_and_f.count && rightCursor >= g_and_h.count) {
    break
  } else if leftCursor >= e_and_f.count {
    e_to_h[index] = e_and_f[rightCursor]
    rightCursor += 1
  } else if rightCursor >= g_and_h.count {
    e_to_h[index] = g_and_h[leftCursor]
    leftCursor += 1
  } else if (e_and_f[leftCursor] >= g_and_h[rightCursor]) {
    e_to_h[index] = g_and_h[rightCursor]
    rightCursor += 1
  } else {
    e_to_h[index] = e_and_f[leftCursor]
    leftCursor += 1
  }
}

print ("Sub-array \"e_to_h\" is now sorted, here is it's contents: \(e_to_h)")

var leftIndex = 0
var rightIndex = 0
var mergedIndex = 0

// However implementing this explicitly is no fun, and isn't terribly efficient
// But I think it's a good way to demonstrate how algorithms work for the sake of learning
// Here is how you implement it in the classic manner, which is through recursion. 
// This is in fact one of the truly classic examples of recurions because the nature of divide-and-conquer algorithms
// The steps taken will be...
// 1. Find middle point of array, or list, or whatever using middleIndex
// 2. Call mergeSort(inputArray, leftIndex, middleIndex) to sort first half of inputArray
// 3. Call mergeSort(inputArray, middleIndex+1, rightIndex) to sort second half
// 4. Merge the two halves using merge(inputArray, leftIndex, middleIndex, rightIndex)

// first we'll define merge as a utility function for the mergeSort function
// This is also a great place to make use of Swift Generics, as any object that's comparable is able to be sorted
// We do this by invoking the "comparable" protocol, which means that any object passed to the function must define functionality for the <, > operators. Which we need because sorts require the ability to compare values. Say we had an array of Persons and we wanted to compare them by their age attribute/property, we would then have to define those operators within the Person class
// Then when we define the function taking the generic input, we use <T: Comparable>
// You may also be wondering about the "inout" keyword, as I've not covered this before. Basically, the default func parameters are in fact constants passed by value. Here we will need to alter the inputArray, and as such it is defined with the inout keyword to tell the compiler we need to alter the parameter.
func mergeSort<T: Comparable>(inout inputArray: [T]) {

  // The exit condition for when recursive calls of self split sub-arrays to 1
  if inputArray.count <= 1 {
    return
  }

  let middleIndex = inputArray.count / 2
  var leftArray = [T]()
  var rightArray = [T]()

  for leftIndex in 0..<middleIndex {
    leftArray.append(inputArray[leftIndex])
  }

  for rightIndex in middleIndex..<inputArray.count {
    rightArray.append(inputArray[rightIndex])
  }

  mergeSort(&leftArray)
  mergeSort(&rightArray)

  print("Sub-arrays of \(leftArray) & \(rightArray)")
  inputArray = merge(&leftArray, rightArray: &rightArray)

}

func merge<T: Comparable>(inout leftArray: [T], inout rightArray:[T]) -> [T]{

  var sortedArray = [T]()

  // Merge by constantly checking current index of sub-arrays
  while (!leftArray.isEmpty && !rightArray.isEmpty)
  {
    if leftArray[0] <= rightArray[0] {
      sortedArray.append(leftArray[0])
      leftArray.removeAtIndex(0)
    } else {
      sortedArray.append(rightArray[0])
      rightArray.removeAtIndex(0)
    }

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

var test = [1, 1, 2, 3, 4, 4, 4, 5, 6, 6, 7, 8, 8, 9]
shuffleInPlace(&test)
print("Shuffled array: \(test)")
mergeSort(&test)














