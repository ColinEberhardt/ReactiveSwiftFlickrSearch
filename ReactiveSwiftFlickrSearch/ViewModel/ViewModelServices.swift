//
//  ViewModelServices.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

// provides common services to view models
protocol ViewModelServices {
  
  // pushes the given ViewMolde onto the stack, this causes the UI to navigate from
  // one view to the next
  func pushViewModel(viewModel:AnyObject)
  
  // provides the search API 
  var flickrSearchService: FlickrSearch { get }
  
}