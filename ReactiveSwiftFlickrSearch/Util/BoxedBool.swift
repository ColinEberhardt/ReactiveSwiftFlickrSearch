//
//  BoxedBool.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class BoxedBool: NSObject, Equatable {
  let value: Bool
  
  init(_ value: Bool) {
    self.value = value
  }
  
  override func isEqual(object: AnyObject!) -> Bool {
    if let otherBool = object as? BoxedBool {
      return otherBool.value == self.value
    }
    return false
  }
}

func ==(lhs: BoxedBool, rhs: BoxedBool) -> Bool {
  return lhs.value == rhs.value
}