//: Playground - noun: a place where people can play

import Cocoa

// define unsorted array in question
var orderedArr: [Int] = [1,2,3,4,5,6,7,8,9]

// shuffle the array with array extensions
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

// array before being sorted
print (orderedArr)
let arr = orderedArr.shuffle()

// lets merge-sort by hand so the method is more clear
// first split the array till each element has it's own sub-set of size 1
// any set of size 1 is always sorted

let a = arr[0]; let b = arr[1]; let c = arr[2]; let d = arr[3]; let e = arr[4]
let f = arr[5]; let g = arr[6]; let h = arr[7]; let i = arr[8]

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
// Merge-sort is a classic example of where to use recursion effectively, since you will need to recurively merge arrays 












