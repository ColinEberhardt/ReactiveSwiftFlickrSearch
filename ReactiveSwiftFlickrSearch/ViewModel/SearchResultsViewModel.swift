//
//  SearchResultsViewModel.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class SearchResultsViewModel {
  
  let services: ViewModelServices
  let searchResults: [FlickrPhoto]
  
  init(services: ViewModelServices, searchResults: [FlickrPhoto]) {
    self.services = services
    self.searchResults = searchResults
  }
}