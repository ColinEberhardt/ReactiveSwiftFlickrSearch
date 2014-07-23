//
//  FlickrSearch.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 14/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

// Provides an API for searching Flickr
protocol FlickrSearch {
  
  // searches Flickr for the given string, returning a signal that emits the response
  func flickrSearchSignal(searchString: String) -> RACSignal
  
  // searches Flickr for the given photo metadata, returning a signal that emits the response
  func flickrImageMetadata(photoId: String) -> RACSignal
}