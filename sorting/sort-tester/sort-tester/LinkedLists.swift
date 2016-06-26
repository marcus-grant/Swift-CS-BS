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
    return tail
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

  public func clear() {
    head!.next = nil
    head = nil
    tail!.previous = nil
    tail = nil
    count = 0
  }

  public func insert(value: T, atIndex index: Int) {
    assert((index >= 0) && (index <= count))

    // if adding next to the end of list, treat as an append
    if index == count {
      append(value);
      return
    }

    count += 1
    let insertedNode = Node(value: value)
    if index == 0 {
      insertedNode.next = head
      insertedNode.previous = nil
      head!.previous = insertedNode
      head = insertedNode
    } else {
      let newNextNode = nodeAtIndex(index)
      insertedNode.previous = newNextNode!.previous
      insertedNode.next = newNextNode
      insertedNode.previous!.next = insertedNode
      newNextNode!.next = insertedNode
    }
  }

  public func map<U>(transform: T -> U) -> LinkedList<U> {
    let result = LinkedList<U>()
    var node = head
    while node != nil {
      result.append(transform(node!.value))
      node = node!.next
    }
    return result
  }

  public func filter(predicate: T -> Bool) -> LinkedList<T> {
    let result = LinkedList<T>()
    var node = head
    while node != nil {
      if predicate(node!.value) {
        result.append(node!.value)
      }
      node = node!.next
    }
    return result
  }
}

public class SimpleListNode<T> {
  var value: T
  var next: SimpleListNode?

  public init(value: T) {
    self.value = value
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