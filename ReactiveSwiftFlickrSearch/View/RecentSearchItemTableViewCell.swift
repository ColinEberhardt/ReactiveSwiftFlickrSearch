//
//  RecentSearchItemTableViewCell.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 16/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class RecentSearchItemTableViewCell: UITableViewCell, ReactiveView {
  
  @IBOutlet var label: UILabel
  
  func bindViewModel(viewModel: AnyObject) {
    let previousSearch = viewModel as PreviousSearchViewModel
    label.text = previousSearch.searchString
  }
}