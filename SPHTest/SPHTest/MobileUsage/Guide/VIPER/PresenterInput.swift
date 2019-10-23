//
//  PresenterInput.swift
//  RnDVIPER
//
//  Created by John Harries on 29/8/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation
import UIKit

public protocol PresenterInput: class {
    func initRouter(navController: UINavigationController)
    func initInteractor()
    func loadViewData()
}
