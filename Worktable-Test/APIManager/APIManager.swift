//
//  APIManager.swift
//  Worktable-Test
//
//  Created by Zubair on 27/07/20.
//  Copyright © 2020 Zubair. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get
    case post
}

enum APIResponse {
    case success(LoginResponse)
    case failure(String)
}

class APIManager {
    class func executeRequest(httpMethod: HTTPMethod, url:String, body: Data, completionHandler:@escaping (APIResponse)->()) {
                
        guard let requestUrl = URL(string: url) else {
            completionHandler(APIResponse.failure("Unsuppported URL!"))
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = httpMethod.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.allHTTPHeaderFields = ["token": "\(token)"]
                    
        request.httpBody = body

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                guard let responseData = data else {
                    completionHandler(APIResponse.failure("Response data is nil"))
                    return
                }
                                
                do {
                   let result = try JSONDecoder().decode(LoginResponse.self, from: responseData)
                    
                    guard let success = result.success else {
                        completionHandler(APIResponse.failure("Request failed."))
                        return
                    }
                    
                    if success {
                        completionHandler(APIResponse.success(result))
                    }
                    else {
                        completionHandler(APIResponse.failure(result.message ?? ""))
                    }
                }
                catch let error {
                    completionHandler(APIResponse.failure(error.localizedDescription))
                }
            }
                
            else {
                completionHandler(APIResponse.failure(error!.localizedDescription))
            }
        }
        
        task.resume()

    }
    
}
