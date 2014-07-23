//
//  FlickrSearchResult.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 14/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

// Represents the result of a Flickr search
class FlickrSearchResults {
  let searchString: String
  let totalResults: Int
  let photos: [FlickrPhoto]
  
  init(searchString: String, totalResults: Int, photos: [FlickrPhoto]) {
    self.searchString = searchString;
    self.totalResults = totalResults
    self.photos = photos
  }
}
