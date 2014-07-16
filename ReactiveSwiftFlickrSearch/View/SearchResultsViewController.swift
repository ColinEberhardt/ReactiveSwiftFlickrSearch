//
//  SearchResultsViewController.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class SearchResultsViewController: UIViewController {
  
  @IBOutlet var searchResultsTable: UITableView
  
  let _viewModel: SearchResultsViewModel
  var _bindingHelper: TableViewBindingHelper!
  
  init(viewModel:SearchResultsViewModel) {
    _viewModel = viewModel

    super.init(nibName: "SearchResultsViewController", bundle: nil)
    
    edgesForExtendedLayout = .None
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    _bindingHelper = TableViewBindingHelper(tableView: searchResultsTable, sourceSignal: RACObserve(_viewModel, "searchResults"), nibName: "SearchResultsTableViewCell")
    
    
  }
}