//
//  SearchResultsTableViewCell.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 16/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class SearchResultsTableViewCell: UITableViewCell, ReactiveView {
  
  @IBOutlet var favouritesLabel: UILabel
  @IBOutlet var commentsLabel: UILabel
  @IBOutlet var favouritesIcon: UIImageView
  @IBOutlet var commentsIcon: UIImageView
  @IBOutlet var imageThumbnailView: UIImageView
  @IBOutlet var titleLabel: UILabel
  
  func bindViewModel(viewModel: AnyObject) {
    let photo = viewModel as SearchResultsItemViewModel
    titleLabel.text = photo.title
    
    signalForImage(photo.url).deliverOn(RACScheduler.mainThreadScheduler())
      .takeUntil(self.rac_prepareForReuseSignal)
      .subscribeNextAs {
        (image: UIImage) -> () in
        self.imageThumbnailView.image = image
      }
    
  }
  
  func signalForImage(imageUrl: NSURL) -> RACSignal{
    let scheduler = RACScheduler(priority: RACSchedulerPriorityBackground)
    let signal = RACSignal.createSignal({
       (subscriber: RACSubscriber!) -> RACDisposable! in
      let data = NSData(contentsOfURL: imageUrl)
      let image = UIImage(data: data)
      subscriber.sendNext(image)
      subscriber.sendCompleted()
      return nil
    })
    return signal.subscribeOn(scheduler)
  }
}

