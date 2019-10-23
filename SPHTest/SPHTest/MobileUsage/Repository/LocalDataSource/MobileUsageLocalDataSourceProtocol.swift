//
//  MobileUsageLocalDataSourceProtocol.swift
//  SPHTest
//
//  Created by John Harries on 17/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation

public protocol MobileUsageLocalDataSourceProtocol: DataSourceProtocol {
    func saveMobileUsage(models: [MobileUsageModel], onComplete: @escaping (Bool, String) -> Void)
    func getMobileUsage(onSuccess: @escaping ([MobileUsageModel]) -> Void, onFailure: @escaping (NSError) -> Void)
}
