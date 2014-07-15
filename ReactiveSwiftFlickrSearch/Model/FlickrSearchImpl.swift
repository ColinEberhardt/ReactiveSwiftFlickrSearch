//
//  FlickrSearchImpl.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 14/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

class FlickrSearchImpl : NSObject, FlickrSearch, OFFlickrAPIRequestDelegate {
  
  let requests: NSMutableSet
  let flickrContext: OFFlickrAPIContext
  var flickrRequest: OFFlickrAPIRequest?
  
  init() {
    let flickrAPIKey = "9d1bdbde083bc30ebe168a64aac50be5";
    let flickrAPISharedSecret = "5fbfa610234c6c23";
    flickrContext = OFFlickrAPIContext(APIKey: flickrAPIKey, sharedSecret:flickrAPISharedSecret)
    
    requests = NSMutableSet()
    
    flickrRequest = nil
  }
  
  func signalFromAPIMethod<T: AnyObject>(method: String, arguments: [String:String],
    transform: (NSDictionary) -> T) -> RACSignal {
      
    return RACSignal.createSignal({
      (subscriber: RACSubscriber!) -> RACDisposable! in
      
      let flickrRequest = OFFlickrAPIRequest(APIContext: self.flickrContext);
      flickrRequest.delegate = self;
      self.requests.addObject(flickrRequest)
      
      func extractSecondTupleArg(signal: RACSignal) -> RACSignal {
        return signal.mapAs { (tuple: RACTuple) -> AnyObject in tuple.second }
      }
      
      let sucessSignal = self.rac_signalForSelector(Selector("flickrAPIRequest:didCompleteWithResponse:"),
        fromProtocol: OFFlickrAPIRequestDelegate.self)
      
      extractSecondTupleArg(sucessSignal)
        .mapAs(transform)
        .subscribeNext {
          (next: AnyObject!) -> () in
          subscriber.sendNext(next)
        }
      
      let failSignal = self.rac_signalForSelector(Selector("flickrAPIRequest:didFailWithError:"),
        fromProtocol: OFFlickrAPIRequestDelegate.self)
      
      extractSecondTupleArg(failSignal).subscribeNextAs {
        (error: NSError) -> () in
        subscriber.sendError(error)
      }
      
      flickrRequest.callAPIMethodWithGET(method, arguments: arguments)
      
      return nil
    })
    
  }
  
  func flickrSearchSignal(searchString: String) -> RACSignal {
    
    func photosFromDictionary (response: NSDictionary) -> FlickrSearchResults {
      let photoArray = response.valueForKeyPath("photos.photo") as [[String: String]]
      let photos = photoArray.map {
        (photoDict: [String:String]) -> FlickrPhoto in
        let url = self.flickrContext.photoSourceURLFromDictionary(photoDict, size: OFFlickrSmallSize)
        return FlickrPhoto(title: photoDict["title"]!, url: url, identifier: photoDict["id"]!)
      }
      let total = response.valueForKeyPath("photos.total").integerValue
      return FlickrSearchResults(searchString: searchString, totalResults: total, photos: photos)
    }
    
    return signalFromAPIMethod("flickr.photos.search",
      arguments: ["text" : searchString, "sort": "interestingness-desc"],
      transform: photosFromDictionary);
  }
  
  
  
}