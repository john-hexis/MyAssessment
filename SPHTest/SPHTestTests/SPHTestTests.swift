//
//  SPHTestTests.swift
//  SPHTestTests
//
//  Created by John Harries on 15/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import XCTest
@testable import SPHTest

class SPHTestTests: XCTestCase {

    func testAPIGetMobileUsageRecordsRowCount() {
        MobileUsageRemoteDataSource().getMobileDataUsage(onSuccess: { response in
            XCTAssertEqual(response.result.total, response.result.records.count)
        }, onError: { error in
            XCTAssertNil(error)
        })
    }
    
    func testSaveMobileUsageModelInLocal() {
        let mobileUsage = MobileUsageModel(id: 1, year: 2019, totalAnnualUsage: 0.0, volumeUsage: 0.0, quarter: "2019 - Q4", isDecreased: false)
        MobileUsageLocalDataSource().saveMobileUsage(models: [mobileUsage]) { (result, message) in
            XCTAssertTrue(result)
        }
    }
    
    func testSaveAndGetMobileUsageModelInLocal() {
        let mobileUsage = MobileUsageModel(id: 1, year: 2019, totalAnnualUsage: 0.0, volumeUsage: 0.0, quarter: "2019 - Q4", isDecreased: false)
        let localDS = MobileUsageLocalDataSource()
        localDS.saveMobileUsage(models: [mobileUsage]) { (result, message) in
            XCTAssertTrue(result)
            localDS.getMobileUsage(onSuccess: { models in
                XCTAssertTrue(models.count > 0)
                if let getModel = models.first {
                    XCTAssertEqual(getModel.id, mobileUsage.id)
                } else {
                    XCTAssertNotNil(models.first)
                }
            }, onFailure: { error in
                XCTAssertTrue(false)
            })
        }
    }
    
    func testGetMobileUsageFromRepository() {
        let repository = MobileUsageRepository(remoteDataSource: MobileUsageRemoteDataSource(), localDataSource: MobileUsageLocalDataSource())
        
        repository.getMobileUsageList(onSuccess: { models in
            XCTAssertTrue(models.count > 0)
        }, onError: { error in
            XCTAssertTrue(false)
        })
    }
}
