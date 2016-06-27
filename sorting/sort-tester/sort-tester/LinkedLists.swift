//
//  DoublyLinkedList.swift
//  sort-tester
//
//  Created by Marcus Grant on 6/25/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//  Using some code from raywenderlich.com http://bit.ly/28Vnhfn but with heavy modification
//

// TODO: Add tail property with included functionality to SimpleLinkedList
// TODO: Conform classes to some collection type or make them subclasses
// TODO: Add thread locking


import Foundation

/////////////////////////////////////////////////////////////////////////////////////////
// MARK: - SingleLinkedList/SimpleLinkedList class
/////////////////////////////////////////////////////////////////////////////////////////

public class SimpleLinkedList<T> {

  // This is done to keep LinkedListNode within same file, and to make a shorter typename
  public typealias Node = SingleLinkNode<T>
  private var head: Node?

  // private(set) makes this variable read-only, it's important users can't change this #
  private(set) var count = 0


  public var isEmpty: Bool {
    return head == nil
  }

  public var first: Node? {
    return head
  }

  public var last: Node? {
    var lastNode = head
    while lastNode!.next != nil {
      lastNode = lastNode!.next
    }
    return lastNode
  }

  // Adds an incrementer for count so count up
  public func append(value: T) {
    let newNode = Node(value: value)
    let lastNode = last
    lastNode!.next = newNode
    count += 1
  }

  // Changed from original, depending on whether the index is closer to the head or tail,
  // it will be faster to traverse the list from the beginning or end.
  // It will still have asymptotic time complexity of O(n), but with half the constant
  public func nodeAtIndex(index: Int) -> Node? {
    // return nil if illegal index of negative value OR greater than count is given
    if index < 0 { return nil }
    if index >= count { return nil }

    // Traverse list forward, till index is reached
    // There should be no over-extending the list, since the check for count is used
    var currentNode = head
    var iterator = 0
    while iterator != index {
      currentNode = currentNode!.next
      iterator += 1
    }
    return currentNode
  }


  // Defining "subscript" means that you can use LIST_NAME[NUMBER] like you can with arrs
  public subscript(index: Int) -> T {
    let node = nodeAtIndex(index)
    // Since it's entirely possible that a number outside the list range is given, which
    // will return a nil, a useless value, use assert(node != nil) to throw an error
    assert(node != nil)
    return node!.value
  }

  public func remove(index: Int) -> T {
    // Check that the given index is within range of the list, otherwise throw error
    assert(index >= 0 && index < count)
    // Update the count property
    count -= 1

    // Traverse the list till iterator reaches index, keeping track of current & prev node
    var removedNode = head
    var previousNode: Node? = nil
    var iterator = 0
    while iterator > index {
      previousNode = removedNode
      removedNode = removedNode!.next
      iterator += 1
      if removedNode!.next == nil { // if the last node is encountered, make previous nil
        previousNode!.next = nil
        removedNode!.next = nil // and remove right pointer from node before return
        return removedNode!.value
      }
    }
    // With the desired node found, disconnect it from the list, and connect surrounding
    previousNode!.next = removedNode!.next
    return removedNode!.value
  }

  public func clear() {
    head!.next = nil
    head = nil
    count = 0
  }

  public func insert(value: T, atIndex index: Int) {
    assert((index >= 0) && (index <= count)) // make sure index is within range of list

    // if adding to the end of list, treat as an append
    if index == count {
      append(value);
      return
    }

    count += 1
    let insertedNode = Node(value: value)
    if index == 0 {
      insertedNode.next = head
      head = insertedNode
    } else {
      let newPrevNode = nodeAtIndex(index - 1)
      insertedNode.next = newPrevNode!.next
      newPrevNode!.next = insertedNode
    }
  }

  public func map<U>(transform: T -> U) -> SimpleLinkedList<U> {
    let result = SimpleLinkedList<U>()
    var node = head
    while node != nil {
      result.append(transform(node!.value))
      node = node!.next
    }
    return result
  }

  public func filter(predicate: T -> Bool) -> SimpleLinkedList<T> {
    let result = SimpleLinkedList<T>()
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

/////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Stack class
/////////////////////////////////////////////////////////////////////////////////////////
public class Stack<T> {
  public typealias Node = SingleLinkNode<T>
  private var head: Node?
  private(set) var count = 0

  public var isEmpty: Bool {
    return head == nil
  }

  public var top: T {
    return head!.value
  }

  public func push(value: T) {
    count += 1
    let newNode = Node(value: value)
    newNode.next = head
    head = newNode
  }

  public init(value: T) {
    push(value)
  }

  public func pop() -> T {
    count -= 1
    return head!.value
  }

  public func clear() {
    head = nil
  }
}

/////////////////////////////////////////////////////////////////////////////////////////
// MARK: - DoublyLinkedList/LinkedList class
/////////////////////////////////////////////////////////////////////////////////////////
public class Queue<T> {
  public typealias Node = SingleLinkNode<T>
  

}


/////////////////////////////////////////////////////////////////////////////////////////
// MARK: - DoublyLinkedList/LinkedList class
/////////////////////////////////////////////////////////////////////////////////////////
public class LinkedList<T> {

  // This is done to keep LinkedListNode within same file, and to make a shorter typename
  public typealias Node = DualLinkedNode<T>
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

  // Adds an incrementer for count so count is correctly updated
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

  private func removeNode(index: Int) -> Node {
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
    return removedNode!
  }

  public func remove(index: Int) -> T {
    let removedNode = removeNode(index)
    return removedNode.value
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

// Several LinkedList methods don't require changing to accomodate the one difference
// of Circularly Linked Lists, the head's previous pointer, points to tail, and vice versa
public class CircularLinkedList<T> : LinkedList<T> {

  // Simply append with parent method and connect head and tail
  override public func append(value: T) {
    super.append(value)
    tail!.next = head
    head!.previous = tail
  }

  // Same as append, simply connect head and tail after super call
  override private func removeNode(index: Int) -> DualLinkedNode<T> {
    let removedNode = super.removeNode(index)
    head!.previous = tail
    tail!.next = head
    return removedNode
  }

  override public func remove(index: Int) -> T {
    return removeNode(index).value
  }

  // Same, connect head to tail, and the reverse
  override public func insert(value: T, atIndex index: Int) {
    super.insert(value, atIndex: index)
    head!.previous = tail
    tail!.next = head
  }
}


public class SingleLinkNode<T> {
  var value: T
  private var next: SingleLinkNode? // Should this be weak? Proably not

  public init(value: T) {
    self.value = value
  }
}

public class DualLinkedNode<T> {
  var value: T
  private var next: DualLinkedNode?
  private weak var previous: DualLinkedNode? // Weak to ensure ARC deallocates when nodes removed

  public init(value: T) {
    self.value = value
  }
}


//////////////////////////////////////////////////////////////////////////////////////////
// Mark: Protocol method defenitions
//////////////////////////////////////////////////////////////////////////////////////////

//public func <=<T>(leftNode: SimpleLinkedListNode<T>, rightNode: SimpleLinkedListNode<T>)
//  -> Bool {
//    return leftNode.value <= rightNode.value
//}
//
//public func ><T>(leftNode: SimpleLinkedListNode<T>, rightNode: SimpleLinkedListNode<T>)
//  -> Bool {
//    return leftNode.value > rightNode.value
//}
//
//public func >=<T>(leftNode: SimpleLinkedListNode<T>, rightNode: SimpleLinkedListNode<T>)
//  -> Bool {
//    return leftNode.value >= rightNode.value
//}
