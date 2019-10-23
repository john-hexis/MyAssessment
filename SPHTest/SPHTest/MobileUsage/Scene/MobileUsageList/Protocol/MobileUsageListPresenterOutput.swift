//
//  MobileUsageListPresenterOutput.swift
//  RnDVIPER
//
//  Created by John Harries on 17/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation

public protocol MobileUsageListPresenterOutput: PresenterOutput {
    func showPopupAlert(message: String)
}
