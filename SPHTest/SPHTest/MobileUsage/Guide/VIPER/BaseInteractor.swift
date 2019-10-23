//
//  BaseInteractor.swift
//  RnDVIPER
//
//  Created by John Harries on 17/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation

class BaseInteractor {
    var output: InteractorOutput?
    
    init(output: InteractorOutput) {
        self.output = output
    }
}
