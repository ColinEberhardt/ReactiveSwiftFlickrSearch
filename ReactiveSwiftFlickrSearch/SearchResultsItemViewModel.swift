//
//  SearchResultsItemViewModel.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 18/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class SearchResultsItemViewModel {
  
  var isVisible: Bool
  let title: String
  let url: NSURL
  var favourites: Int?
  var comments: Int?
  
  let _services: ViewModelServices
  
  init(photo: FlickrPhoto, services: ViewModelServices) {
    _services = services
    title = photo.title
    url = photo.url
    isVisible = false
  }
  
}
