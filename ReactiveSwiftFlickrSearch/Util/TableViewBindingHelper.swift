//
//  TableViewBindingHelper.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class TableViewBindingHelper: NSObject, UITableViewDataSource {
  
  let tableView: UITableView
  var data: [FlickrPhoto]
  
  init(tableView: UITableView, sourceSignal: RACSignal) {
    self.tableView = tableView
    self.data = []
    
    super.init()
    
   /* sourceSignal.subscribeNextAs {
      (data:[FlickrPhoto]) -> () in
      self.data = data
      self.tableView.reloadData()
    }*/
    
    sourceSignal.subscribeNext {
      (d:AnyObject!) -> () in
      self.data = d as [FlickrPhoto]
      self.tableView.reloadData()
    }
    
    
    tableView.dataSource = self
  }
  
  func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
    let photo = data[indexPath.row]
    let cell = UITableViewCell()
    cell.textLabel.text = photo.title
    return cell
  }
  
}
