//
//  MobileUsageDataAccess.swift
//  SPHTest
//
//  Created by John Harries on 23/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation

class MobileUsageDataAccess: BaseDataAccess<MobileUsageModel> {
    override func getContainerName() -> String {
        return "SPHTest"
    }
    
    override func genericName() -> String {
        return "MobileUsage"
    }
}
