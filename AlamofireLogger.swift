//
//  AlamofireLogger.swift
//  Ticketing
//
//  Created by STQRY8 on 10/12/15.
//  Copyright © 2015 Stqry. All rights reserved.
//

import Alamofire

extension Request {
    
    public enum LogLevel {
        case Simple
        case Verbose
    }
    
    public func log(level level: LogLevel = .Simple) -> Self {
        return logRequest(level: level).logResponse(level: level)
    }
    
    public func logRequest(level level: LogLevel = .Simple) -> Self {
        guard let request = request else {
            return self
        }
        
        guard let method = request.HTTPMethod, let path = request.URL?.absoluteString else {
            return self
        }
        
        if let data = request.HTTPBody, body = NSString(data: data, encoding: NSUTF8StringEncoding) where level == .Verbose {
            print("\(method) \(path): \"\(body)\"")
        } else {
            print("\(method) \(path)")
        }
        
        return self
    }
    
    public func logResponse(level level: LogLevel = .Simple) -> Self {
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
            
            if let data = data, body = NSString(data: data, encoding: NSUTF8StringEncoding) where level == .Verbose {
                print("\(response.statusCode) \(path): \"\(body)\"")
            } else {
                print("\(response.statusCode) \(path)")
            }
        }
        
        return self
    }
    
}
