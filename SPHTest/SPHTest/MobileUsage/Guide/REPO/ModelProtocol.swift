//
//  ModelProtocol.swift
//  SPHTest
//
//  Created by John Harries on 17/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation
import CoreData

public protocol ModelProtocol {
    var entityName: String { get }
    
    init(managedObject: NSManagedObject)
    func setValue(to managedObject: NSManagedObject)
}
