//
//  ViewModelServicesImpl.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class ViewModelServicesImpl: ViewModelServices {
  
  private let navigationController: UINavigationController
  let flickrSearchService: FlickrSearch
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.flickrSearchService = FlickrSearchImpl()
  }
  
  func pushViewModel(viewModel:AnyObject) {
    if let searchResultsViewModel = viewModel as? SearchResultsViewModel {
      self.navigationController.pushViewController(SearchResultsViewController(viewModel: searchResultsViewModel), animated: true)
    }
  }
}