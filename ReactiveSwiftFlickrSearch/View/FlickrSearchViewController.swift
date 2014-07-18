//
//  FlickrSearchViewController.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class FlickrSearchViewController: UIViewController {

  @IBOutlet var searchTextField: UITextField
  @IBOutlet var searchButton: UIButton
  @IBOutlet var searchHistoryTable: UITableView
  @IBOutlet var loadingIndicator: UIActivityIndicatorView
  
  let _viewModel: FlickrSearchViewModel
  var _bindingHelper: TableViewBindingHelper!
  
  init(viewModel:FlickrSearchViewModel) {
    _viewModel = viewModel
    
    super.init(nibName: "FlickrSearchViewController", bundle: nil)
    
    edgesForExtendedLayout = .None
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bindViewModel()
  }
  
  func bindViewModel() {
    searchTextField.rac_textSignal() ~> RAC(_viewModel, "searchText")
    
    _viewModel.executeSearch.executing.NOT() ~> RAC(loadingIndicator, "hidden")
    
    _viewModel.executeSearch.executing ~> RAC(UIApplication.sharedApplication(), "networkActivityIndicatorVisible")
    
    searchButton.rac_command = _viewModel.executeSearch
    
    _bindingHelper = TableViewBindingHelper(tableView: searchHistoryTable, sourceSignal: RACObserve(_viewModel, "previousSearches"), nibName: "RecentSearchItemTableViewCell")
    
    _viewModel.connectionErrors.subscribeNextAs {
      (error: NSError) -> () in
      let alert = UIAlertView(title: "Connection Error", message: "There was a problem reaching Flickr", delegate: nil, cancelButtonTitle: "OK")
      alert.show()
    }
    
    // for some reason having this code within the subscribeNext closure
    // causes a build error
    func resign() -> () {
      searchTextField.resignFirstResponder()
    }
    _viewModel.executeSearch.executionSignals.subscribeNext{(any:AnyObject!) -> () in
      resign()
    }
  }

}
