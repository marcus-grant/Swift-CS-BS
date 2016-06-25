//
//  DoublyLinkedList.swift
//  sort-tester
//
//  Created by Marcus Grant on 6/25/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//  Using code from RayWenderlich.com http://bit.ly/28Vnhfn
//

import Foundation

public class LinkedList<T> {
  public typealias Node = LinkedListNode<T>
  private var head: Node?
  private var tail: Node?

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

  public func append(value: T) {
    let newNode = Node(value: value)
    if let lastNode = last {
      newNode.previous = lastNode
      lastNode.next = newNode
    } else {
      head = newNode
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

//Testing
/////////////////////////////////////////////////////////

var list = LinkedList<String>()
list.isEmpty              // true
list.first                // nil
list.append("Hello")
list.isEmpty              // false
list.first!.value         // "Hello"
list.last!.value          // "Hello" - first & last are the same

// Add another node to see if first & last works
list.append("World!")
