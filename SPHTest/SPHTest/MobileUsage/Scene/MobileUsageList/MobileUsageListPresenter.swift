//
//  MobileUsageListPresenter.swift
//  SPHTest
//
//  Created by John Harries on 16/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation
import UIKit

class MobileUsageListPresenter: BasePresenter {
    fileprivate var records: [MobileUsageModel] = []
    fileprivate var interactorInput: MobileUsageListInteractorInput {
        get {
            return (self.interactor as! MobileUsageListInteractorInput)
        }
    }
    fileprivate var routerInput: MobileUsageListRouterInput {
        get {
            return (self.router as! MobileUsageListRouterInput)
        }
    }
    fileprivate var presenterOutput: MobileUsageListPresenterOutput {
        get {
            return (self.output as! MobileUsageListPresenterOutput)
        }
    }
    
    required init(output: PresenterOutput, navController: UINavigationController) {
        super.init(output: output)
        self.initRouter(navController: navController)
    }
}

extension MobileUsageListPresenter: MobileUsageListPresenterInput {
    var recordCount: (rows: Int, sections: Int) {
        get {
            let sectionCount = Set(records.map { $0.year }).count
            return (rows: records.count, sections: sectionCount)
        }
    }
    
    var recordDictionary: [(section: (year: Int, total: Double), rows: [MobileUsageModel])] {
        get {
            var result: [(section: (year: Int, total: Double), rows: [MobileUsageModel])] = []
            for year in Set(records.map { $0.year }) {
                let row = records.filter { record -> Bool in
                    return record.quarter.hasPrefix(String(year))
                }
                result.append((section: (year: year, total: row.first?.totalAnnualUsage ?? 0.0), rows: row))
            }
            return result.sorted { (prev, next) -> Bool in
                prev.section.year < next.section.year
            }
        }
    }
    
    func initRouter(navController: UINavigationController) {
        self.router = MobileUsageListRouter(output: self, navController: navController)
    }
    
    func initInteractor() {
        self.interactor = MobileUsageListInteractor(output: self)
        self.interactorInput.initRepository()
    }
    
    func loadViewData() {
        self.interactorInput.getMobileUsageList()
    }
}

extension MobileUsageListPresenter: MobileUsageListInteractorOutput {
    func processMobileUsageList(model: [MobileUsageModel]) {
        self.records = model
        DispatchQueue.main.async {
            self.presenterOutput.updateView()
        }
    }
}

extension MobileUsageListPresenter: MobileUsageListRouterOutput {
    
}
