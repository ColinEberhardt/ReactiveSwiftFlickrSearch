//
//  ViewController.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 06/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var impl: FlickrSearchImpl?
                            
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    impl = FlickrSearchImpl();
    var sig = impl!.flickrSearchSignal("fish")
    sig.subscribeNext{
      (next: AnyObject!) -> () in
      let results = next as FlickrSearchResults
      println(results)
      println(results.photos[0].title)

    }
    
    
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

