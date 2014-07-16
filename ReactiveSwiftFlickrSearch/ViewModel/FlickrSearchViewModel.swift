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
  let connectionErrors: RACSignal!
  var previousSearches: [PreviousSearchViewModel]
  
  let _flickSearch: FlickrSearch
  let _services: ViewModelServices
  
  init(services: ViewModelServices) {
    
    _services = services
    _flickSearch = FlickrSearchImpl()
    previousSearches = []
    
    super.init()
    
    let validSearchSignal = RACObserve(self, "searchText").mapAs {
        (text: NSString) -> NSNumber in
        return text.length > 4
      }.distinctUntilChanged();
    
    executeSearch = RACCommand(enabled: validSearchSignal) {
      (any:AnyObject!) -> RACSignal in
      return self._executeSearchSignal()
    }
    connectionErrors = executeSearch.errors
   
  }
  
  func _executeSearchSignal() -> RACSignal {
    return _flickSearch.flickrSearchSignal(searchText).doNextAs {
      (results: FlickrSearchResults) -> () in
      let viewModel = SearchResultsViewModel(services: self._services, searchResults: results.photos)
      self._services.pushViewModel(viewModel)
      self._addToSearchHistory(results)
    }
  }
  
  func _addToSearchHistory(result: FlickrSearchResults) {
    let matches = previousSearches.filter { $0.searchString == self.searchText }
    
    var previousSearchesUpdated = previousSearches


    if matches.count > 0 {
      let match = matches[0]
      var withoutMatch = previousSearchesUpdated.filter { $0.searchString != self.searchText }
      withoutMatch.insert(match, atIndex: 0)
      previousSearchesUpdated = withoutMatch
    } else {
      let previousSearch = PreviousSearchViewModel(searchString: searchText, totalResults: result.totalResults, thumbnail: result.photos[0].url)
      previousSearchesUpdated.insert(previousSearch, atIndex: 0)
    }
    
    if (previousSearchesUpdated.count > 10) {
      previousSearchesUpdated.removeLast()
    }
    
    previousSearches = previousSearchesUpdated
  }

}
