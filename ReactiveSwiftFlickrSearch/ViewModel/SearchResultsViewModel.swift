//
//  SearchResultsViewModel.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class SearchResultsViewModel: NSObject {
  
  let services: ViewModelServices
  var searchResults: [SearchResultsItemViewModel]
  
  init(services: ViewModelServices, searchResults: [FlickrPhoto]) {
    self.services = services
    self.searchResults = searchResults.map { SearchResultsItemViewModel(photo: $0, services: services ) }
    
    super.init()
  }
}