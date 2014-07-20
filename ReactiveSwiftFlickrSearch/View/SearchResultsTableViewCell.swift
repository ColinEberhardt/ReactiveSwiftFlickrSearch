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
    
    self.clipsToBounds = true
    
    imageThumbnailView.contentMode = .ScaleToFill
    
    signalForImage(photo.url).deliverOn(RACScheduler.mainThreadScheduler())
      .takeUntil(self.rac_prepareForReuseSignal)
      .subscribeNextAs {
        (image: UIImage) -> () in
        self.imageThumbnailView.image = image
      }
    
    RACObserve(photo, "favourites").subscribeNextAs {
      (faves:NSNumber) -> () in
      self.favouritesLabel.text = faves == -1 ? "" : "\(faves)"
      self.favouritesIcon.hidden = faves == -1
    }
    
    RACObserve(photo, "comments").subscribeNextAs {
      (comments:NSNumber) -> () in
      self.commentsLabel.text = comments == -1 ? "" : "\(comments)"
      self.commentsIcon.hidden = comments == -1
    }
    
    photo.isVisible = true
    self.rac_prepareForReuseSignal.subscribeNext {
      (next: AnyObject!) -> () in
      self.imageThumbnailView.image = nil
      photo.isVisible = false
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
  
  func setParallax(value:Float) {
    imageThumbnailView.transform = CGAffineTransformMakeTranslation(0, value)
  }
}

