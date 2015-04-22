//
//  RACSignal+Extensions.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

// a collection of extension methods that allows for strongly typed closures
extension RACSignal {
  
  func subscribeNextAs<T>(nextClosure:(T) -> ()) -> () {
    self.subscribeNext {
      (next: AnyObject!) -> () in
      let nextAsT = next! as! T
      nextClosure(nextAsT)
    }
  }
  
  func mapAs<T: AnyObject, U: AnyObject>(mapClosure:(T) -> U) -> RACSignal {
    return self.map {
      (next: AnyObject!) -> AnyObject! in
      let nextAsT = next as! T
      return mapClosure(nextAsT)
    }
  }
  
  func filterAs<T: AnyObject>(filterClosure:(T) -> Bool) -> RACSignal {
    return self.filter {
      (next: AnyObject!) -> Bool in
      let nextAsT = next as! T
      return filterClosure(nextAsT)
    }
  }
  
  func doNextAs<T: AnyObject>(nextClosure:(T) -> ()) -> RACSignal {
    return self.doNext {
      (next: AnyObject!) -> () in
      let nextAsT = next as! T
      nextClosure(nextAsT)
    }
  }
}

class RACSignalEx {
  class func combineLatestAs<T, U, R: AnyObject>(signals:[RACSignal], reduce:(T,U) -> R) -> RACSignal {
    return RACSignal.combineLatest(signals).mapAs {
      (tuple: RACTuple) -> R in
      return reduce(tuple.first as! T, tuple.second as! U)
    }
  }
}
