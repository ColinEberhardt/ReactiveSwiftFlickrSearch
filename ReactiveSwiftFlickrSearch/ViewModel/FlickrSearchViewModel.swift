//
//  FlickrSearchViewModel.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

// The top-level ViewModel, exposes an interface that allows you
// to search Flickr via a search string It also displays the 
// history of recent searches
class FlickrSearchViewModel: NSObject {
  
  //MARK: Properties
  
  dynamic var searchText = ""
  dynamic var previousSearches: [PreviousSearchViewModel]
  var executeSearch: RACCommand?
  let title = "Flickr Search"
  var previousSearchSelected: RACCommand!
  var connectionErrors: RACSignal!
  
  private let services: ViewModelServices
  
  //MARK: Public APIprintln
  
  init(services: ViewModelServices) {
    
    self.services = services
    previousSearches = []
    
    super.init()
    
    let validSearchSignal = RACObserve(self, "searchText").mapAs {
        (text: NSString) -> NSNumber in
        return text.length > 3
      }.distinctUntilChanged();
    
    executeSearch = RACCommand(enabled: validSearchSignal) {
      (any:AnyObject!) -> RACSignal in
      return self.executeSearchSignal()
    }
    connectionErrors = executeSearch!.errors
    
    previousSearchSelected = RACCommand() {
      (any:AnyObject!) -> RACSignal in
      let previousSearch = any as! PreviousSearchViewModel
      self.searchText = previousSearch.searchString
      return self.executeSearchSignal()
    }
    
  }
  
  //MARK: Private methods
  
  private func executeSearchSignal() -> RACSignal {
    return services.flickrSearchService.flickrSearchSignal(searchText).doNextAs {
      (results: FlickrSearchResults) -> () in
      let viewModel = SearchResultsViewModel(services: self.services, searchResults: results)
      self.services.pushViewModel(viewModel)
      self.addToSearchHistory(results)
    }
  }
  
  private func addToSearchHistory(result: FlickrSearchResults) {
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
