//
//  NetworkActivityLogMode.swift
//  Alamofire
//
//  Created by Daniel Clelland on 29/06/20.
//

import Foundation
import os

public enum NetworkActivityLogMode {
    
    case `default`
    
    case system(log: OSLog = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "", category: "Network"))
    
}

extension NetworkActivityLogMode {
    
    internal func print(log networkActivityLog: NetworkActivityLog) {
        switch self {
        case .default:
            Swift.print(networkActivityLog.message)
        case .system(let log):
            os_log("%{public}s", log: log, type: networkActivityLog.type, networkActivityLog.message)
        }
    }
    
}
