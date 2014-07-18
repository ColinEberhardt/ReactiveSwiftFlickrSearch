//
//  ViewModelServices.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

protocol ViewModelServices {
  
  func pushViewModel(viewModel:AnyObject)
  
  var flickrSearchService: FlickrSearch { get }
  
}