//
//  AlamofireLogger.swift
//  Ticketing
//
//  Created by STQRY8 on 10/12/15.
//  Copyright © 2015 Stqry. All rights reserved.
//

import Alamofire

// MARK: AlamofireLogger extension

extension Request {
  
    /// The logging level. `Simple` prints only a brief request/response description; `Verbose` prints the request/response body as well.
    public enum LogLevel {
        /// Prints the request and response at their respective `Simple` levels.
        case Simple
        /// Prints the request and response at their respective `Verbose` levels.
        case Verbose
    }
    
    /// Log the request and response at the specified `level`.
    public func log(level level: LogLevel = .Simple) -> Self {
        switch level {
        case .Simple:
            return logRequest(level: .Simple).logResponse(level: .Simple)
        case .Verbose:
            return logRequest(level: .Verbose).logResponse(level: .Verbose)
        }
    }
    
    /// The request logging level. `Simple` prints only the HTTP method and path; `Verbose` prints the request body as well.
    public enum RequestLogLevel {
        /// Print the request's HTTP method and path.
        case Simple
        /// Print the request's HTTP method, path, and body.
        case Verbose
    }
    
    /// Log the request at the specified `level`.
    public func logRequest(level level: RequestLogLevel = .Simple) -> Self {
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
    
    /// The response logging level. `Simple` prints only the HTTP status code and path; `Verbose` prints the response body as well.
    public enum ResponseLogLevel {
        /// Print the response's HTTP status code and path, or error if one is returned.
        case Simple
        /// Print the response's HTTP status code, path, and body, or error if one is returned.
        case Verbose
    }
    
    /// Log the response at the specified `level`.
    public func logResponse(level level: ResponseLogLevel = .Simple) -> Self {
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
