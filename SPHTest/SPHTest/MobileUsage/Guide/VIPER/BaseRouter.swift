//
//  BaseRouter.swift
//  RnDVIPER
//
//  Created by John Harries on 17/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation
import UIKit

class BaseRouter {
    var navController: UINavigationController?
    var output: RouterOutput?

    init(output: RouterOutput, navController: UINavigationController) {
        self.output = output
        self.navController = navController
    }
}
