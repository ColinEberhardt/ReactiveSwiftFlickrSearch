//
//  FlickrSearchViewModel.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class FlickrSearchViewModel: NSObject {
  
  var searchText = ""
  let executeSearch: RACCommand!
  let flickSearch: FlickrSearch
  let services: ViewModelServices
  
  init(services: ViewModelServices) {
    
    self.services = services
    flickSearch = FlickrSearchImpl()
    
    super.init()
    
    let validSearchSignal = RACObserve(self, "searchText").mapAs {
      (text: NSString) -> NSNumber in
      return text.length > 4
      }.distinctUntilChanged();
    
    
    executeSearch = RACCommand(enabled: validSearchSignal) {
      (any:AnyObject!) -> RACSignal in
      return self.executeSearchSignal()
    }
  }
  
  func executeSearchSignal() -> RACSignal {
    return flickSearch.flickrSearchSignal(searchText).doNextAs {
      (results: FlickrSearchResults) -> () in
      let viewModel = SearchResultsViewModel(services: self.services, searchResults: results.photos)
      self.services.pushViewModel(viewModel)
      println(results)
    }
  }
  
}
