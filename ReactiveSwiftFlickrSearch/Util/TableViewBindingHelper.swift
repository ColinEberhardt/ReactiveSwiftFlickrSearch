//
//  TableViewBindingHelper.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

@objc protocol ReactiveView {
  func bindViewModel(viewModel: AnyObject)
}

class TableViewBindingHelper: NSObject, UITableViewDataSource, UITableViewDelegate {
  
  let tableView: UITableView
  let templateCell: UITableViewCell
  var delegate: UITableViewDelegate?
  var data: [AnyObject]

  
  init(tableView: UITableView, sourceSignal: RACSignal, nibName: String) {
    self.tableView = tableView
    self.data = []
    
    let nib = UINib(nibName: nibName, bundle: nil)

    // create an instance of the template cell and register with the table view
    templateCell = nib.instantiateWithOwner(nil, options: nil)[0] as UITableViewCell
    tableView.registerNib(nib, forCellReuseIdentifier: templateCell.reuseIdentifier)
    
    super.init()
    
    sourceSignal.subscribeNext {
      (d:AnyObject!) -> () in
      self.data = d as [AnyObject]
      self.tableView.reloadData()
    }
    
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
    let item: AnyObject = data[indexPath.row]
    let cell = tableView.dequeueReusableCellWithIdentifier(templateCell.reuseIdentifier) as UITableViewCell
    if let reactiveView = cell as? ReactiveView {
      reactiveView.bindViewModel(item)
    }
    return cell
  }
  
  func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
    return templateCell.frame.size.height
  }
  
  func scrollViewDidScroll(scrollView: UIScrollView!) {
    if self.delegate?.respondsToSelector(Selector("scrollViewDidScroll:")) {
      self.delegate?.scrollViewDidScroll?(scrollView);
    }
  }
  
  /*override func respondsToSelector(aSelector: Selector) -> Bool {
    if self.delegate?.respondsToSelector(aSelector) {
      return true
    }
    return super.respondsToSelector(aSelector)
  }
  
  override func forwardingTargetForSelector(aSelector: Selector) -> AnyObject! {
    if self.delegate? .respondsToSelector(aSelector) {
      return self.delegate
    }
    return super.forwardingTargetForSelector(aSelector)
  }*/
}
