//
//  MobileUsageRepository.swift
//  SPHTest
//
//  Created by John Harries on 16/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation

public class MobileUsageRepository: BaseTwoDSRepository<MobileUsageRemoteDataSource,MobileUsageLocalDataSource> {
    
    private var mobileUsageCache: [MobileUsageModel] = []
    
    static var _instance: MobileUsageRepository?
    static var shared: MobileUsageRepository {
        get {
            guard let instance = _instance else {
                
                return MobileUsageRepository(remoteDataSource: MobileUsageRemoteDataSource(), localDataSource: MobileUsageLocalDataSource())
            }
            
            return instance
        }
    }

    func getMobileUsageList(onSuccess: @escaping ([MobileUsageModel]) -> Void, onError: @escaping (NSError) -> Void) {
        if mobileUsageCache.count > 0 {
            onSuccess(mobileUsageCache)
        } else {
            self.localDataSource.getMobileUsage(onSuccess: { models in
                if models.count > 0 {
                    let result = models.sorted { (prev, next) -> Bool in
                        prev.quarter < next.quarter
                    }
                    onSuccess(result)
                } else {
                    self.remoteDataSource.getMobileDataUsage(onSuccess: { response in
                        self.mobileUsageCache = MobileUsageModel.mapper(records: response.result)
                        self.localDataSource.saveMobileUsage(models: self.mobileUsageCache) { (result, message) in
                            print(message)
                            onSuccess(self.mobileUsageCache)
                        }
                    }) { error in
                        onError(error)
                    }
                }
            }, onFailure: { error in
                onError(error)
            })
        }
    }
}
