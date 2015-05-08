//
//  SearchResultsViewController.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class SearchResultsViewController: UIViewController, UITableViewDelegate {
  
  @IBOutlet var searchResultsTable: UITableView!
  
  private let viewModel: SearchResultsViewModel
  private var bindingHelper: TableViewBindingHelper!
  
  required init(coder: NSCoder) {
    fatalError("NSCoding not supported")
  }
  
  init(viewModel:SearchResultsViewModel) {
    self.viewModel = viewModel

    super.init(nibName: "SearchResultsViewController", bundle: nil)
    
    edgesForExtendedLayout = .None
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = viewModel.title
    
    bindingHelper = TableViewBindingHelper(tableView: searchResultsTable, sourceSignal: RACObserve(viewModel, "searchResults"), nibName: "SearchResultsTableViewCell")
    bindingHelper.delegate = self
  }
  
  func scrollViewDidScroll(scrollView: UIScrollView!) {
    let cells = searchResultsTable.visibleCells()
    for cell in cells as! [SearchResultsTableViewCell] {
      let value = -40.0 + (cell.frame.origin.y - searchResultsTable.contentOffset.y) / 5.0;
      cell.setParallax(value)
    }
  }
}