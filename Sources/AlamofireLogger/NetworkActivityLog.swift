//
//  NetworkActivityLog.swift
//  Alamofire
//
//  Created by Daniel Clelland on 29/06/20.
//

import Foundation
import os

public struct NetworkActivityLog {
    
    public var message: String
    
    internal var type: OSLogType
    
}

extension NetworkActivityLog {
    
    public static func `default`(_ message: String) -> NetworkActivityLog {
        return NetworkActivityLog(message: message, type: .default)
    }
    
    public static func info(_ message: String) -> NetworkActivityLog {
        return NetworkActivityLog(message: message, type: .info)
    }
    
    public static func debug(_ message: String) -> NetworkActivityLog {
        return NetworkActivityLog(message: message, type: .debug)
    }
    
    public static func error(_ message: String) -> NetworkActivityLog {
        return NetworkActivityLog(message: message, type: .error)
    }
    
    public static func fault(_ message: String) -> NetworkActivityLog {
        return NetworkActivityLog(message: message, type: .fault)
    }
    
}
