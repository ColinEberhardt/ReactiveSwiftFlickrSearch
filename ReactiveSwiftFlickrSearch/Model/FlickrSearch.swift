//
//  FlickrSearch.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 14/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

protocol FlickrSearch {
  
  func flickrSearchSignal(searchString: String) -> RACSignal
  
  func flickrImageMetadata(photoId: String) -> RACSignal
}