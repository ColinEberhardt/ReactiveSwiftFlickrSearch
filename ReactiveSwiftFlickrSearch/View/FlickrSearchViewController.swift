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
  
  let viewModel: FlickrSearchViewModel
  
  init(viewModel:FlickrSearchViewModel) {
    self.viewModel = viewModel
    
    super.init(nibName: "FlickrSearchViewController", bundle: nil)
    
    edgesForExtendedLayout = .None

  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bindViewModel()
  }
  
  func bindViewModel() {
    searchTextField.rac_textSignal() ~> RAC(viewModel, "searchText")
    
    searchButton.rac_command = viewModel.executeSearch
  }
}
