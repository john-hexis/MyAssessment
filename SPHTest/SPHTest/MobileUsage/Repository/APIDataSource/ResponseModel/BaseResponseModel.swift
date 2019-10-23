//
//  BaseResponseModel.swift
//  SPHTest
//
//  Created by John Harries on 21/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation

public struct BaseResponseModel<T>: ResponseModelProtocol where T: ResultProtocol {
    var help: String
    var success: Bool
    var result: T
}

extension BaseResponseModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case help = "help"
        case success = "success"
        case result = "result"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        help = try container.decode(String.self, forKey: .help)
        success = try container.decode(Bool.self, forKey: .success)
        result = try container.decode(T.self, forKey: .result)
    }
}

public protocol ResultProtocol: Decodable {}
