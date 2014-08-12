//
//  RAC.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

// a struct that replaces the RAC macro
struct RAC  {
  var target : NSObject!
  var keyPath : String!
  var nilValue : AnyObject!
  
  init(_ target: NSObject!, _ keyPath: String, nilValue: AnyObject? = nil) {
    self.target = target
    self.keyPath = keyPath
    self.nilValue = nilValue
  }
  
  
  func assignSignal(signal : RACSignal) {
    signal.setKeyPath(self.keyPath, onObject: self.target, nilValue: self.nilValue)
  }
}

infix operator ~> {}
func ~> (signal: RACSignal, rac: RAC) {
  rac.assignSignal(signal)
}