//
//  BaseRepository.swift
//  SPHTest
//
//  Created by John Harries on 17/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation

public class BaseTwoDSRepository<T,U>: RepositoryProtocol where T: DataSourceProtocol, U: DataSourceProtocol {

    var remoteDataSource: T
    var localDataSource: U
    
    public init(remoteDataSource: T, localDataSource: U) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
}

public class BaseOneDSRepository<T>: RepositoryProtocol where T: DataSourceProtocol {
    var remoteDataSource: T
    
    public init(remoteDataSource: T) {
        self.remoteDataSource = remoteDataSource
    }
}
