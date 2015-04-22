//
//  AppDelegate.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 06/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
  var window: UIWindow?
  
  var navigationController: UINavigationController!

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
    navigationController = UINavigationController()
    navigationController.navigationBar.barTintColor = UIColor.darkGrayColor()
    navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    
    let viewModelServices = ViewModelServicesImpl(navigationController: navigationController)
    
    let viewModel = FlickrSearchViewModel(services: viewModelServices)
    let viewController = FlickrSearchViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: false)
    
    
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    window!.rootViewController = navigationController
    window!.makeKeyAndVisible()
    
    return true
  }
}

