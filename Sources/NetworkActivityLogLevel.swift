//
//  NetworkActivityLogLevel.swift
//  AlamofireLogger
//
//  Created by Daniel Clelland on 29/06/20.
//

import Foundation
import Alamofire

public struct NetworkActivityLogLevel {
    
    public typealias StartFormatter = (DataRequest) -> String?
    
    public typealias StopFormatter = (DataRequest) -> String?
    
    public var startFormatter: StartFormatter
    
    public var stopFormatter: StopFormatter
    
}

extension NetworkActivityLogLevel {
    
    public static let none = NetworkActivityLogLevel(
        startFormatter: { request in
            return nil
        },
        stopFormatter: { request in
            return nil
        }
    )
    
    public static let simple = NetworkActivityLogLevel(
        startFormatter: { request in
            return request.description
        },
        stopFormatter: { request in
            if let error = request.task?.error {
                return "\(request.description) \"\(error.localizedDescription)\""
            } else {
                return request.description
            }
        }
    )
    
    public static let verbose = NetworkActivityLogLevel(
        startFormatter: { request in
            if let body = request.request?.httpBody.flatMap({ String(data: $0, encoding: .utf8) }) {
                return "\(request.description) \"\(body)\""
            } else {
                return request.description
            }
        },
        stopFormatter: { request in
            if let error = request.task?.error {
                return "\(request.description) \"\(error.localizedDescription)\""
            } else if let body = request.data.flatMap({ String(data: $0, encoding: .utf8) }) {
                return "\(request.description) \"\(body)\""
            } else {
                return request.description
            }
        }
    )
    
}

extension NetworkActivityLogLevel {
    
    public static func custom(startFormatter: @escaping StartFormatter, stopFormatter: @escaping StopFormatter) -> NetworkActivityLogLevel {
        return NetworkActivityLogLevel(
            startFormatter: startFormatter,
            stopFormatter: stopFormatter
        )
    }
    
}
