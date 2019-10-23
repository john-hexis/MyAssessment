//
//  MobileUsageRemoteDataSourceProtocol.swift
//  SPHTest
//
//  Created by John Harries on 17/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation

public protocol MobileUsageRemoteDataSourceProtocol: DataSourceProtocol {
    func getMobileDataUsage(onSuccess: @escaping (BaseResponseModel<MobileUsageResponseModel>) -> Void, onError: @escaping (NSError) -> Void)
}
