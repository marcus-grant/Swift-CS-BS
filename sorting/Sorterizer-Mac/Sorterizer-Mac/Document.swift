//
//  Document.swift
//  Sorterizer-Mac
//
//  Created by Marcus Grant on 6/29/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//

import Cocoa

class Document: NSPersistentDocument {

  override init() {
      super.init()
    // Add your subclass-specific initialization here.
  }

  override class func autosavesInPlace() -> Bool {
    return true
  }

  override func makeWindowControllers() {
    // Returns the Storyboard that contains your Document window.
    let storyboard = NSStoryboard(name: "Main", bundle: nil)
    let windowController = storyboard.instantiateControllerWithIdentifier("Document Window Controller") as! NSWindowController
    self.addWindowController(windowController)
  }

}
