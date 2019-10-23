//
//  MobileUsageResponseModel.swift
//  SPHTest
//
//  Created by John Harries on 21/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation

public struct MobileUsageResponseModel {
//    var resourceId: UUID
    var fields: [MobileUsageField]
    var records: [MobileUsageRecord]
    var links: MobileUsageLinks
    var total: Int
}

extension MobileUsageResponseModel: ResultProtocol {
    enum CodingKeys: String, CodingKey {
//        case resourceId = "resource_id"
        case fields = "fields"
        case records = "records"
        case links = "_links"
        case total = "total"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
//        resourceId = try container.decode(UUID.self, forKey: .resourceId)
        fields = try container.decode([MobileUsageField].self, forKey: .fields)
        records = try container.decode([MobileUsageRecord].self, forKey: .records)
        links = try container.decode(MobileUsageLinks.self, forKey: .links)
        total = try container.decode(Int.self, forKey: .total)
    }
}

public struct MobileUsageField {
    var id: String
    var type: String
}

extension MobileUsageField: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
    }
}

public struct MobileUsageRecord {
    var id: Int
    var quarter: String
    var volumeOfMobileData: String
}

extension MobileUsageRecord: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case quarter = "quarter"
        case volumeOfMobileData = "volumeOfMobileData"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        quarter = try container.decode(String.self, forKey: .quarter)
        volumeOfMobileData = try container.decode(String.self, forKey: .volumeOfMobileData)
    }
}

public struct MobileUsageLinks {
    var start: String
    var next: String
}

extension MobileUsageLinks: Decodable {
    enum CodingKeys: String, CodingKey {
        case start = "start"
        case next = "next"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        start = try container.decode(String.self, forKey: .start)
        next = try container.decode(String.self, forKey: .next)
    }
}
