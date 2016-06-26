//
//  DoublyLinkedList.swift
//  sort-tester
//
//  Created by Marcus Grant on 6/25/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//  Using some code from raywenderlich.com http://bit.ly/28Vnhfn but with heavy modification
//

import Foundation

public class LinkedList<T> {

  // This is done to keep LinkedListNode within same file, and to make a shorter typename
  public typealias Node = LinkedListNode<T>
  private var head: Node?
  private var tail: Node?
  // private(set) makes this variable read-only, it's important users can't change this #
  private(set) var count = 0


  public var isEmpty: Bool {
    return head == nil
  }

  public var first: Node? {
    return head
  }

  public var last: Node? {
    if var node = head {
      while case let next? = node.next {
        node = next
      }
      return node
    } else { return nil }
  }

  // Adds an incrementer for count so count up
  public func append(value: T) {
    let newNode = Node(value: value)
    if let lastNode = last {
      newNode.previous = lastNode
      lastNode.next = newNode
      tail = newNode
    } else {
      head = newNode
      tail = newNode
    }
    count += 1
  }

  // Changed from original, depending on whether the index is closer to the head or tail,
  // it will be faster to traverse the list from the beginning or end.
  // It will still have asymptotic time complexity of O(n), but with half the constant
  public func nodeAtIndex(index: Int) -> Node? {
    // return nil if illegal index of negative value is given
    if index < 0 { return nil }
    if index >= count { return nil }

    // Since the "count" property tracks list size, dividing it by 2 using " >> 1 "
    // helps quickly determine if it's faster to traverse the list from head or tail
    var currentNode: Node?
    var iterator: Int
    if index <= count >> 1 { // traverse list forward from head node
      iterator = 0
      currentNode = head
      while currentNode != nil {
        if iterator == index { return currentNode }
        currentNode = currentNode!.next
        iterator += 1
      }
    } else { // traverse list backwards from tail node
      iterator = count - 1
      currentNode = tail
      while currentNode != nil {
        if iterator == index { return currentNode }
        currentNode = currentNode!.previous
        iterator -= 1
      }
    }
    return nil // won't ever happen, but there needs to be a return for all cases
  }


  // Defining "subscript" means that you can use LIST_NAME[NUMBER] like you can with arrays
  public subscript(index: Int) -> T {
    let node = nodeAtIndex(index)
    // Since it's entirely possible that a number outside the list range is given, which
    // will return a nil, a useless value, use assert(node != nil) to throw an error
    assert(node != nil)
    return node!.value
  }

  public func remove(index: Int) -> T {
    let removedNode = nodeAtIndex(index)
    assert(removedNode != nil)
    if index == 0 {
      head = removedNode!.next
      head!.previous = nil
    } else if index == count - 1 {
      tail = removedNode!.previous
      tail!.next = nil
    } else {
      removedNode!.previous!.next = removedNode!.next!
      removedNode!.next!.previous = removedNode!.previous!
    }
    count -= 1
    removedNode!.next = nil
    removedNode!.previous = nil
    return removedNode!.value
  }

  public func insert(value: T, atIndex index: Int) {
    assert(index >= 0 || index <= count)
    if index == count { self.append(value); return }
    let newNode = Node(value)
    if index == 0 {
      newNode.next = head
      head.previous = newNode
      head = newNode
    } else {

    }




    let newNode = Node(value: value)
    let (newNextNode, newPrevNode) = currentNodeAndPrevious(index)
    print ("newNextNode value: \(newNextNode!.value)")
    print ("newPrevNoce value: \(newPrevNode!.value)")
    count += 1
    if index == 0 {
      print("Inserting new head node")
      newNode.next = head // newNode.next point to old head
      newNode.previous = nil
      head!.previous = newNode // old head node's previous points to new node at new head
      head = newNode // set new head node to newNode
      return
    }
      newNode.next = newNextNode
      newNode.previous = newPrevNode
      newNextNode!.previous = newNode
      newPrevNode!.next = newNode
    }
  }



}


public class LinkedListNode<T> {
  var value: T
  var next: LinkedListNode?
  var previous: LinkedListNode?

  public init(value: T) {
    self.value = value
  }
}

// MARK: Testing
/////////////////////////////////////////////////////////

var list = LinkedList<String>()
list.isEmpty              // true
list.first                // nil
list.append("Hello")
list.isEmpty              // false
list.first!.value         // "Hello"
list.last!.value          // "Hello" - first & last are the same

// Add another node to see if first & last works
list.append("World")
list.first!.value         // "Hello"
list.last!.value          // "World"

// Check to see if first node has anything before it, or the last after
list.first!.previous      // nil
list.last!.next           // nil, both nil as it should be

// check to see count, and nodeAtIndex(index) works
list.count                // 2
list.nodeAtIndex(0)?.value //"Hello"
list.nodeAtIndex(1)?.value //"World"
//list.nodeAtIndex(2)!.value // ERROR

// Check to see that subscripting works
list[0]                   // "Hello"
list[1]                   // "World"
//list[2]                 // ERROR

// Check that remove works
list.append("A")
list.append("B")
list.count                // 4
list.remove(2)            // "A"
list.count                // 3
list.remove(2)            // "B"
list.count                // 2
//list.remove(2)          // ERROR

// Test that insert(value,index) works
list.insert(" ", atIndex: 1)
list.count                // 3
list[2]
list.insert("!", atIndex: 2)
list.count                // 4
list.first?.value         // "Hello"
list[1]                   // " "
list[2]                   //
list[3]




