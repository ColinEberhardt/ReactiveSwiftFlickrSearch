//
//  RACSignal+Extensions.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

extension RACSignal {
  func subscribeNextAs<T>(nextClosure:(T) -> ()) -> () {
    self.subscribeNext {
      (next: AnyObject!) -> () in
      let nextAsT = next as T
      nextClosure(nextAsT)
    }
  }
  
  func mapAs<T: AnyObject, U: AnyObject>(mapClosure:(T) -> (U)) -> RACSignal {
    return self.map {
      (next: AnyObject!) -> AnyObject! in
      let nextAsT = next as T
      return mapClosure(nextAsT)
    }
  }
}
