//
//  URLSession+Request.swift
//  SPHTest
//
//  Created by John Harries on 20/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation

struct URLSessionResponse {
    let response: HTTPURLResponse?
    let data: Any?
    let error: NSError?
}

extension URLSession {
    enum HTTPMethod: String {
        case options = "OPTIONS"
        case get     = "GET"
        case head    = "HEAD"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
        case trace   = "TRACE"
        case connect = "CONNECT"
    }

    typealias HTTPHeaders = [String: String]
    typealias HTTPParams = [String: Any]
    
    func getHeaders() -> HTTPHeaders {
        return ["Accept": "application/json",
                "Content-Type": "application/json",
                "cache-control": "no-cache"]
    }
    
    func request(url: String, method: HTTPMethod, headers: HTTPHeaders = [:], params: HTTPParams = [:], onSuccess: ((URLSessionResponse) -> Void)? = nil, onError: ((NSError) -> Void)? = nil) {
        do {
            let url = URL(string: url)
            var urlRequest = URLRequest(url: url!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30.0)
            
            urlRequest.httpMethod = method.rawValue
            urlRequest.allHTTPHeaderFields = getHeaders()
            
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)

            switch method {
            case .get:
                let task = session.dataTask(with: urlRequest) { (data, response, error) in
                    guard let onSuccessHandler = onSuccess else { return }
                    onSuccessHandler(URLSessionResponse(response: response as? HTTPURLResponse, data: data, error: error as NSError?))
                }
                task.resume()
            default:
                if params.count > 0 {
                    let jsonData = try JSONSerialization.data(withJSONObject: params)
                    
                    let task = session.uploadTask(with: urlRequest, from: jsonData, completionHandler: { (data, response, error) in
                       
                        guard let onSuccessHandler = onSuccess else { return }
                        onSuccessHandler(URLSessionResponse(response: response as? HTTPURLResponse, data: data, error: error as NSError?))
                    })
                    task.resume()
                } else {
                    let task = session.uploadTask(with: urlRequest, from: nil, completionHandler: { (data, response, error) in
                       
                        guard let onSuccessHandler = onSuccess else { return }
                        onSuccessHandler(URLSessionResponse(response: response as? HTTPURLResponse, data: data, error: error as NSError?))
                    })
                    task.resume()
                }
            }
        } catch let error as NSError {
            guard let onErrorHandler = onError else { return }
            onErrorHandler(error)
        }
    }
}
