//
//  AppCoordinator.swift
//  Reciplease
//
//  Created by Margarita Blanc on 20/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class AppCoordinator {

    // MARK: - Properties

    private unowned var appDelegate: AppDelegate
    
    private var tabCoordinator: TabCoordinator!

    // MARK: - Init
    
    init(appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
    }

    // MARK: - Coordinator

    func start() {
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window!.rootViewController = UIViewController()
        appDelegate.window!.makeKeyAndVisible()
        
        showTab()
    }
    
    private func showTab() {
        tabCoordinator = TabCoordinator(presenter: appDelegate.window!)
        tabCoordinator.start()
    }
}
