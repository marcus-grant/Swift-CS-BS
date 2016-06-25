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
    return tail
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