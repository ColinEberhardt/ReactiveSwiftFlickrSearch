//
//  SearchResultsItemViewModel.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 18/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

// A ViewModel that backs an individual photo in a search result view.
class SearchResultsItemViewModel: NSObject {
  
  dynamic var isVisible: Bool
  dynamic var favourites: NSNumber
  dynamic var comments: NSNumber
  let title: String
  let url: NSURL
  var identifier: String
  
  private let services: ViewModelServices
  
  init(photo: FlickrPhoto, services: ViewModelServices) {
    self.services = services
    title = photo.title
    url = photo.url
    identifier = photo.identifier
    isVisible = false
    favourites = -1
    comments = -1
    
    super.init()
    
    // a signal that emits events when visibility changes
    let visibleStateChanged = RACObserve(self, keyPath: "isVisible").skip(1)

    // filtered into visible and hidden signals
    let visibleSignal = visibleStateChanged.filter { $0.boolValue }
    let hiddenSignal = visibleStateChanged.filter { !$0.boolValue }

    // a signal that emits when an item has been visible for 1 second
    let fetchMetadata = visibleSignal.delay(1).takeUntil(hiddenSignal)

    fetchMetadata.subscribeNext {
      (next: AnyObject!) -> () in
      self.services.flickrSearchService.flickrImageMetadata(self.identifier).subscribeNextAs {
        (metadata: FlickrPhotoMetadata) -> () in
        self.favourites = metadata.favourites
        self.comments = metadata.comments
      }
    }
    
  }
  
}
