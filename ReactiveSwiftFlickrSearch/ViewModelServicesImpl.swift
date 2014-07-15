//
//  ViewModelServicesImpl.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class ViewModelServicesImpl: ViewModelServices {
  
  let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func pushViewModel(viewModel:AnyObject) {
    if let searchResultsViewModel = viewModel as? SearchResultsViewModel {
      navigationController.pushViewController(SearchResultsViewController(viewModel: searchResultsViewModel), animated: true)
    }
  }
}