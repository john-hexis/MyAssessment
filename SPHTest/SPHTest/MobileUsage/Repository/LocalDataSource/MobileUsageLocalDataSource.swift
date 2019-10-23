//
//  MobileUsageLocalDataSource.swift
//  SPHTest
//
//  Created by John Harries on 17/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation

public class MobileUsageLocalDataSource: MobileUsageLocalDataSourceProtocol {

    let mobileUsageDataAccess = MobileUsageDataAccess()
    
    public func saveMobileUsage(models: [MobileUsageModel], onComplete: @escaping (Bool, String) -> Void) {
        self.mobileUsageDataAccess.createRange(entities: models, onSuccess: {
            onComplete(true, "Models had been saved successfully.")
        }, onFailure: { error in
            onComplete(false, "Models is failed to save.")
        })
    }
    
    public func getMobileUsage(onSuccess: @escaping ([MobileUsageModel]) -> Void, onFailure: @escaping (NSError) -> Void) {
        self.mobileUsageDataAccess.retrieveAll(onSuccess: { models in
            onSuccess(models)
        }, onFailure: { error in
            onFailure(error)
        })
    }
}
