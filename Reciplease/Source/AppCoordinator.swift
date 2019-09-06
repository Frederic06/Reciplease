//
//  AppCoordinator.swift
//  Reciplease
//
//  Created by Margarita Blanc on 20/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

// ViewController is responsible for controlling all visual stuff, elements labels, animations, colors, font etc.

// Instead of segues, AppCoordinator is responsible from transition between views

// AppCoordinator is responsible for setting an entry point, we hide the entry point (fleche) in the storyBoard, it's the MakeKeyInvisible propertie
final class AppCoordinator {
    
    private unowned var appDelegate: AppDelegate
    
    private var tabCoordinator: TabCoordinator!
    
    init(appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
    }
    
    func start() {
        
        //We instantiate window, from Window which comes from AppDelegate, its parameters is main.bound, size of the user screen
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        
        // First VC, we put an empty instance of UIViewController
        appDelegate.window!.rootViewController = UIViewController()
        
        // We set it as the entry point of our app
        appDelegate.window!.makeKeyAndVisible()
        
        showTab()
    }
    
    private func showTab() {
        // Its owns instances of Views, we have 3, we made an array with 3 UIViewControllers
        tabCoordinator = TabCoordinator(presenter: appDelegate.window!)
        tabCoordinator.start()
    }
}



