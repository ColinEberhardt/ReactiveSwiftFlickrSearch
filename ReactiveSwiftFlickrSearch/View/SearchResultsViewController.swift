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
  
  let viewModel: SearchResultsViewModel
  var bindingHelper: TableViewBindingHelper!
  
  init(viewModel:SearchResultsViewModel) {
    self.viewModel = viewModel

    
    super.init(nibName: "SearchResultsViewController", bundle: nil)
    
    edgesForExtendedLayout = .None
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bindingHelper = TableViewBindingHelper(tableView: searchResultsTable, sourceSignal: RACObserve(self.viewModel, "searchResults"))
    
    
  }
}