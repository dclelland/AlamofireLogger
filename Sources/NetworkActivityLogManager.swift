//
//  NetworkActivityLogManager.swift
//  NetworkActivityLogManager
//
//  Created by Daniel Clelland on 10/12/15.
//  Copyright © 2015 Daniel Clelland. All rights reserved.
//

import Alamofire

public class NetworkActivityLogManager {
    
    public static let shared = NetworkActivityLogManager()
    
    public var level: NetworkActivityLogLevel = .none
    
    public var mode: NetworkActivityLogMode = .default
    
    init() {
        registerForNotifications()
    }
    
    deinit {
        unregisterForNotifications()
    }
    
}

extension NetworkActivityLogManager {
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(NetworkActivityLogManager.networkRequestDidStart), name: Request.didResumeTaskNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NetworkActivityLogManager.networkRequestDidStop), name: Request.didCompleteTaskNotification, object: nil)
    }
    
    private func unregisterForNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension NetworkActivityLogManager {
    
    @objc private func networkRequestDidStart(notification: Notification) {
        guard let request = notification.request as? DataRequest else {
            return
        }
        
        guard let log = level.startFormatter(request) else {
            return
        }
        
        mode.print(log: log)
    }

    @objc private func networkRequestDidStop(notification: Notification) {
        guard let request = notification.request as? DataRequest else {
            return
        }
        
        guard let log = level.stopFormatter(request) else {
            return
        }
        
        mode.print(log: log)
    }
    
}
