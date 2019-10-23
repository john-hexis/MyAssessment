//
//  Services.swift
//  SPHTest
//
//  Created by John Harries on 20/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation

class Services {
    private static var baseURL = {
        return "https://data.gov.sg"
    }
    
    enum API {
        case ActionDataStore
        
        func path(query: [String:String]) -> String {
            var queryString = ""
            for item in query {
                if queryString == "" {
                    queryString = "?\(item.key)=\(item.value)"
                } else {
                    queryString = "\(queryString)&\(item.key)=\(item.value)"
                }
            }
            
            switch self {
            case .ActionDataStore:
                return String(format: "%@/api/action/datastore_search%@", baseURL(), queryString)
            }
        }
    }
}
