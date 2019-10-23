//
//  BaseDataAccess.swift
//  SPHTest
//
//  Created by John Harries on 22/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BaseDataAccess<T> where T: ModelProtocol {
    internal func getContainerName() -> String {
        return ""
    }
    
    internal func genericName() -> String {
        return ""
    }
    
    private(set) lazy var privateManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    private(set) lazy var mainManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.parent = self.privateManagedObjectContext
        return managedObjectContext
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let container = NSPersistentContainer(name: self.getContainerName())
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in

            if let error = error as NSError? {
              fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container.persistentStoreCoordinator
    }()
    
    func create(entity: T, onSuccess: @escaping () -> Void, onFailure: @escaping (NSError) -> Void) {
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: entity.entityName, in: self.mainManagedObjectContext) else {
            onFailure(NSError(domain: "Failed to get NSEntityDescription", code: 100, userInfo: nil))
            return
        }
        
        self.mainManagedObjectContext.perform {
            let managedObject = NSManagedObject(entity: entityDescription, insertInto: self.mainManagedObjectContext)
            
            entity.setValue(to: managedObject)
            
            do {
                try self.mainManagedObjectContext.save()
                onSuccess()
            } catch let error as NSError {
                onFailure(error)
            }
//
//            self.privateManagedObjectContext.perform({
//                do {
//                    if self.privateManagedObjectContext.hasChanges {
//                        try self.privateManagedObjectContext.save()
//                    }
//                    onSuccess()
//                } catch let error as NSError {
//                    onFailure(error)
//                }
//            })
        }
    }
    
    func createRange(entities: [T], onSuccess: @escaping () -> Void, onFailure: @escaping (NSError) -> Void) {
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: entities[0].entityName, in: self.mainManagedObjectContext) else {
            onFailure(NSError(domain: "Failed to get NSEntityDescription", code: 100, userInfo: nil))
            return
        }
        
        self.mainManagedObjectContext.perform {
            for item in entities {
                let managedObject = NSManagedObject(entity: entityDescription, insertInto: self.mainManagedObjectContext)
                
                item.setValue(to: managedObject)
            }
            
            do {
                try self.mainManagedObjectContext.save()
                onSuccess()
            } catch let error as NSError {
                onFailure(error)
            }
        }
    }
    
    func deleteAll(onSuccess: @escaping () -> Void, onFailure: @escaping (NSError) -> Void){
        
        let entityName = self.genericName()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        self.mainManagedObjectContext.perform {
            do {
                let fetchContext = try self.mainManagedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
                for item in fetchContext {
                    self.mainManagedObjectContext.delete(item)
                }
                
                do {
                    try self.mainManagedObjectContext.save()
                    onSuccess()
                } catch let error as NSError {
                    onFailure(error)
                }
            } catch let error as NSError {
                onFailure(error)
            }
        }
    }
    
    func retrieveAll(onSuccess: @escaping ([T]) -> Void, onFailure: @escaping (NSError) -> Void) {

        let entityName = self.genericName()

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        self.mainManagedObjectContext.perform {
            var result:[T] = []
            
            do {
                guard let managedObjects = try self.mainManagedObjectContext.fetch(fetchRequest) as? [NSManagedObject] else {
                    onSuccess([])
                    return
                }
                
                for managedObject in managedObjects {
                    result.append(T(managedObject: managedObject))
                }
                
                onSuccess(result)
            } catch let error as NSError {
                onFailure(error)
            }
        }
    }
}
