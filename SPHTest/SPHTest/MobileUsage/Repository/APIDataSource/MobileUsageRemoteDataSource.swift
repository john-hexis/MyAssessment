//
//  MobileUsageRemoteDataSource.swift
//  SPHTest
//
//  Created by John Harries on 17/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation

public class MobileUsageRemoteDataSource: MobileUsageRemoteDataSourceProtocol {
    public func getMobileDataUsage(onSuccess: @escaping (BaseResponseModel<MobileUsageResponseModel>) -> Void, onError: @escaping (NSError) -> Void) {
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        let url = Services.API.ActionDataStore.path(query: ["resource_id" : "a807b7ab-6cad-4aa6-87d0-e283a7353a0f"])
        
        urlSession.request(
            url: url,
            method: .get,
            onSuccess: { response in
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dateDecodingStrategy = .secondsSince1970
                    if let data = response.data as? Data {
                        let responseData = try decoder.decode(BaseResponseModel<MobileUsageResponseModel>.self, from: data)
                        onSuccess(responseData)
                    } else {
                        onError(NSError(domain: "com.personal.SPHTest: Data is nil", code: 100, userInfo: nil))
                    }

                }
                catch let error {
                    onError(error as NSError)
                }
        }) { error in
            onError(error)
        }
    }
}
