//
//  PreviousSearchViewModel.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 16/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

// Represents a search that was executed previously
class PreviousSearchViewModel: NSObject {

  let searchString: String
  let totalResults: Int
  let thumbnail: NSURL
  
  init(searchString: String, totalResults: Int, thumbnail: NSURL) {
    self.searchString = searchString
    self.totalResults = totalResults
    self.thumbnail = thumbnail
  }
}