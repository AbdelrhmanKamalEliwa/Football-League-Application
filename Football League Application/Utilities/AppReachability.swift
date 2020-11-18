//
//  AppReachability.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/15/20.
//

import Foundation
import Reachability

class AppReachability {
    static let shared = AppReachability()
    private let reachability = try! Reachability()
    private let defaults = UserDefaults.standard
    private init() {}
    
    func setRechabilityNotifier() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reachabilityChanged),
            name: .reachabilityChanged,
            object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    @objc
    private func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        switch reachability.connection {
        case .none:
            defaults.setValue(false, forKey: "Reachability")
            print("none")
        case .unavailable:
            defaults.setValue(false, forKey: "Reachability")
            print("unavailable")
        case .wifi:
            defaults.setValue(true, forKey: "Reachability")
            print("wifi")
        case .cellular:
            defaults.setValue(true, forKey: "Reachability")
            print("cellular")
        }
    }
    
    func removeRechabilityNotifier() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(
            self,
            name: .reachabilityChanged,
            object: reachability)
    }
}
