//
//  AlamofireLogger.swift
//  Ticketing
//
//  Created by STQRY8 on 10/12/15.
//  Copyright © 2015 Stqry. All rights reserved.
//

import Alamofire

extension Request {
    
    func log(verbose verbose: Bool = true) -> Self {
        return logRequest(verbose: verbose).logResponse(verbose: verbose)
    }
    
    func logRequest(verbose verbose: Bool = true) -> Self {
        guard let request = request else {
            return self
        }
        
        guard let method = request.HTTPMethod, let path = request.URL?.absoluteString else {
            return self
        }
        
        if let data = request.HTTPBody, body = NSString(data: data, encoding: NSUTF8StringEncoding) where verbose == true {
            print("\(method) \(path): \"\(body)\"")
        } else {
            print("\(method) \(path)")
        }
        
        return self
    }
    
    func logResponse(verbose verbose: Bool = true) -> Self {
        response { request, response, data, error in
            guard let response = response else {
                if let path = request?.URL?.absoluteString, description = error?.localizedDescription {
                    print("XXX \(path): \"\(description)\"")
                }
                return
            }
            
            guard let path = response.URL?.absoluteString else {
                return
            }
            
            if let data = data, body = NSString(data: data, encoding: NSUTF8StringEncoding) where verbose == true {
                print("\(response.statusCode) \(path): \"\(body)\"")
            } else {
                print("\(response.statusCode) \(path)")
            }
        }
        
        return self
    }
    
}
