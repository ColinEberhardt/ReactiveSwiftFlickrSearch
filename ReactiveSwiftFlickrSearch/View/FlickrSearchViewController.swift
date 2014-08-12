//
//  FlickrSearchViewController.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class FlickrSearchViewController: UIViewController {

  @IBOutlet var searchTextField: UITextField!
  @IBOutlet var searchButton: UIButton!
  @IBOutlet var searchHistoryTable: UITableView!
  @IBOutlet var loadingIndicator: UIActivityIndicatorView!
  
  private let viewModel: FlickrSearchViewModel
  private var bindingHelper: TableViewBindingHelper!
  
  required init(coder: NSCoder) {
    fatalError("NSCoding not supported")
  }
  
  init(viewModel:FlickrSearchViewModel) {
    self.viewModel = viewModel
    
    super.init(nibName: "FlickrSearchViewController", bundle: nil)
    
    edgesForExtendedLayout = .None
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bindViewModel()
  }
  
  private func bindViewModel() {
    title = viewModel.title
    
    searchTextField.rac_textSignal() ~> RAC(viewModel, "searchText")
    
    viewModel.executeSearch.executing.NOT() ~> RAC(loadingIndicator, "hidden")
    
    viewModel.executeSearch.executing ~> RAC(UIApplication.sharedApplication(), "networkActivityIndicatorVisible")
    
    searchButton.rac_command = viewModel.executeSearch
    
    bindingHelper = TableViewBindingHelper(tableView: searchHistoryTable,
      sourceSignal: RACObserve(viewModel, "previousSearches"), nibName: "RecentSearchItemTableViewCell",
      selectionCommand: viewModel.previousSearchSelected)
    
    viewModel.connectionErrors.subscribeNextAs {
      (error: NSError) -> () in
      let alert = UIAlertView(title: "Connection Error", message: "There was a problem reaching Flickr", delegate: nil, cancelButtonTitle: "OK")
      alert.show()
    }
    
    // for some reason having this code within the subscribeNext closure
    // causes a build error
    func resign() -> () {
      searchTextField.resignFirstResponder()
    }
    viewModel.executeSearch.executionSignals.subscribeNext{(any:AnyObject!) -> () in
      resign()
    }
  }

}
