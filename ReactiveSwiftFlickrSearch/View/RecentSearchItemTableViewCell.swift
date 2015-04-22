//
//  RecentSearchItemTableViewCell.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 16/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class RecentSearchItemTableViewCell: UITableViewCell, ReactiveView {
  
  
  @IBOutlet var thumbnailImage: UIImageView!
  @IBOutlet var totalResultsLabel: UILabel!
  @IBOutlet var recentSearchLabel: UILabel!
  
  func bindViewModel(viewModel: AnyObject) {
    let previousSearch = viewModel as! PreviousSearchViewModel
    recentSearchLabel.text = previousSearch.searchString
    totalResultsLabel.text = "\(previousSearch.totalResults)"
    
    let data = NSData(contentsOfURL: previousSearch.thumbnail)
    let image = UIImage(data: data!)
    thumbnailImage.image = image
  }
}