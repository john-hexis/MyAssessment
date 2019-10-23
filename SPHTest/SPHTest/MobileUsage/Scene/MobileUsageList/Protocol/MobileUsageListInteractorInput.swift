//
//  MobileUsageListInteractorInput.swift
//  RnDVIPER
//
//  Created by John Harries on 17/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation

public protocol MobileUsageListInteractorInput: InteractorInput {
    func initRepository()
    func getMobileUsageList()
}
