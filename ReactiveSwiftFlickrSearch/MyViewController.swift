//
//  MyViewController.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 16/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class MyViewController: UIViewController, UITableViewDataSource {
  
  var tableView: UITableView!
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView = UITableView(frame: self.view.bounds)
    self.view.addSubview(tableView)
    
    
    let nib = UINib(nibName: "MyCell", bundle: nil)
    
    // create an instance of the template cell and register with the table view
    tableView.registerNib(nib, forCellReuseIdentifier: "foo")
    
    

  //  tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "foo")
    tableView.dataSource = self
  }
  
  func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int  {
    return 5
  }
  
  func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
    let cell = tableView.dequeueReusableCellWithIdentifier("foo") as UITableViewCell
    cell.textLabel.text = "foo"
    return cell
  }
  
}
