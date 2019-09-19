//
//  MockAlertDelegate.swift
//  Reciplease
//
//  Created by Margarita Blanc on 19/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

final class MockAlertDelegate: AlertDelegate {
    func displayAlert(type: AlertType) {
        print("alert")
    }
}
