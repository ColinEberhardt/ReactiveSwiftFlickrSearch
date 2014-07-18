//
//  ViewModelServicesImpl.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class ViewModelServicesImpl: ViewModelServices {
  
  let _navigationController: UINavigationController
  let _flickrSearchService: FlickrSearch
  
  var flickrSearchService: FlickrSearch {
    get {
      return _flickrSearchService
    }
  }
  
  init(navigationController: UINavigationController) {
    _navigationController = navigationController
    _flickrSearchService = FlickrSearchImpl()
  }
  
  func pushViewModel(viewModel:AnyObject) {
    if let searchResultsViewModel = viewModel as? SearchResultsViewModel {
      _navigationController.pushViewController(SearchResultsViewController(viewModel: searchResultsViewModel), animated: true)
    }
  }
}