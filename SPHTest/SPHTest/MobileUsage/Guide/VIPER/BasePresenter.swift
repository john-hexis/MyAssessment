//
//  BasePresenter.swift
//  RnDVIPER
//
//  Created by John Harries on 17/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation

public class BasePresenter {
    var interactor: InteractorInput?
    var router: RouterInput?
    var output: PresenterOutput?
    
    init(output: PresenterOutput) {
        self.output = output
    }
}
