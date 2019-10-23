//
//  MobileUsageListInteractor.swift
//  SPHTest
//
//  Created by John Harries on 16/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation

class MobileUsageListInteractor: BaseInteractor {
    fileprivate var interactorOutput: MobileUsageListInteractorOutput {
        get {
            return self.output as! MobileUsageListInteractorOutput
        }
    }
    var mobileUsageRepository: MobileUsageRepository?
}

extension MobileUsageListInteractor: MobileUsageListInteractorInput {

    func initRepository() {
        self.mobileUsageRepository = MobileUsageRepository.shared
    }
    
    func getMobileUsageList() {
        self.mobileUsageRepository?.getMobileUsageList(onSuccess: { model in

            self.interactorOutput.processMobileUsageList(model: model)
        }, onError: { error in
            print("ERROR: \(error.localizedDescription)")
        })
    }
    
}
