//
//  FlickrPhoto.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 14/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

// represents a single photo in a Flickr search
class FlickrPhoto {

  let title :String
  let url :NSURL
  let identifier :String
  
  init (title: String, url: NSURL, identifier: String) {
    self.title = title
    self.url = url
    self.identifier = identifier
  }

}
