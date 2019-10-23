//
//  MobileUsageListPresenterInput.swift
//  RnDVIPER
//
//  Created by John Harries on 17/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation

public protocol MobileUsageListPresenterInput: PresenterInput {
    var recordCount: (rows: Int, sections: Int) { get }
    var recordDictionary: [(section: (year: Int, total: Double), rows: [MobileUsageModel])] { get }
}
