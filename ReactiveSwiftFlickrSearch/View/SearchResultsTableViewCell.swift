//
//  SearchResultsTableViewCell.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 16/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class SearchResultsTableViewCell: UITableViewCell, ReactiveView {
  
  @IBOutlet var label: UILabel
  
  func bindViewModel(viewModel: AnyObject) {
    let photo = viewModel as FlickrPhoto
    label.text = photo.title
  }
}