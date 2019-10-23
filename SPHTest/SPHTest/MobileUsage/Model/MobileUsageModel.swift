//
//  MobileUsageModel.swift
//  SPHTest
//
//  Created by John Harries on 16/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation
import CoreData

public struct MobileUsageModel {
    var id: Int
    var year: Int
    var totalAnnualUsage: Double
    var volumeUsage: Double
    var quarter: String
    var isDecreased: Bool
    
    private enum Keys {
        case id
        case year
        case totalAnnualUsage
        case volumeUsage
        case quarter
        case isDecreased
        
        func getKey() -> String {
            switch self {
                case .id: return "id"
                case .year: return "year"
                case .totalAnnualUsage: return "totalAnnualUsage"
                case .volumeUsage: return "volumeUsage"
                case .quarter: return "quarter"
                case .isDecreased: return "isDecreased"
            }
        }
    }
    
    static func mapper(records entity: MobileUsageResponseModel) -> [MobileUsageModel] {
        
        let yearAndTotals = Set(entity.records.map { record -> String in
            let yearIndex = record.quarter.firstIndex(of: "-")!
            return String(record.quarter[..<yearIndex])
        }).map { year -> (year: String, total: Double) in
            let total = entity.records.filter({$0.quarter.hasPrefix(year)}).reduce(0) { (result, next) -> Double in
                return result + (Double(next.volumeOfMobileData) ?? 0.0)
            }
            return (year: year, total: total)
        }
        
        let sortedRecords = entity.records.sorted(by: { (prev, next) -> Bool in
            prev.quarter < next.quarter
        })
        
        let indicators = sortedRecords.reduce(into: [(quarter: String, isDecreased: Bool, volume: Double)]()) { (result, record) in
            if result.count == 0 {
                result.append((quarter: record.quarter, isDecreased: false, volume: Double(record.volumeOfMobileData) ?? 0.0))
            } else {
                let isDecreased = (result.last?.volume ?? 0.0) > (Double(record.volumeOfMobileData) ?? 0.0)
                result.append((quarter: record.quarter, isDecreased: isDecreased, volume: Double(record.volumeOfMobileData) ?? 0.0))
            }
        }
        
        return sortedRecords.map { record -> MobileUsageModel in
            let yearIndex = record.quarter.firstIndex(of: "-")!
            let year = String(record.quarter[..<yearIndex])
            
            let totalUsage = yearAndTotals.first(where: {$0.year == year})?.total ?? 0.0
            let isDecreased = indicators.first(where: {$0.quarter == record.quarter})?.isDecreased ?? false
            
            return MobileUsageModel(id: record.id, year: Int(year) ?? 0, totalAnnualUsage: totalUsage, volumeUsage: Double(record.volumeOfMobileData) ?? 0.0, quarter: record.quarter, isDecreased: isDecreased)
        }
    }
}

extension MobileUsageModel: ModelProtocol {
    
    public init(managedObject: NSManagedObject) {
        self.id = (managedObject.value(forKey: Keys.id.getKey()) as? Int) ?? 0
        self.year = (managedObject.value(forKey: Keys.year.getKey()) as? Int) ?? 0
        self.totalAnnualUsage = (managedObject.value(forKey: Keys.totalAnnualUsage.getKey()) as? Double) ?? 0.0
        self.volumeUsage = (managedObject.value(forKey: Keys.volumeUsage.getKey()) as? Double) ?? 0.0
        self.quarter = (managedObject.value(forKey: Keys.quarter.getKey()) as? String) ?? ""
        self.isDecreased = (managedObject.value(forKey: Keys.isDecreased.getKey()) as? Bool) ?? false
    }
    
    public var entityName: String {
        get { return "MobileUsage" }
    }
    
    public func setValue(to managedObject: NSManagedObject) {
        managedObject.setValue(self.id, forKey: Keys.id.getKey())
        managedObject.setValue(self.year, forKey: Keys.year.getKey())
        managedObject.setValue(self.totalAnnualUsage, forKey: Keys.totalAnnualUsage.getKey())
        managedObject.setValue(self.volumeUsage, forKey: Keys.volumeUsage.getKey())
        managedObject.setValue(self.quarter, forKey: Keys.quarter.getKey())
        managedObject.setValue(self.isDecreased, forKey: Keys.isDecreased.getKey())
    }
}
