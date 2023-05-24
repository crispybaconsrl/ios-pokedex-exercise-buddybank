//
//  NetworkHelper.swift
//  Pokemon
//
//  Created by Luca Davanzo on 24/05/23.
//

import Foundation
import SystemConfiguration

enum PokemonEndpoint {
    case pokemonList
    case pokemonDetails(Int)
    
    var rawValue: String {
        switch self {
        case .pokemonList:
            return "pokemon"
        case .pokemonDetails(let index):
            return "pokemon/\(index)"
        }
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol NetworkStatusDelegate: AnyObject {
    func networkStatusDidChange(isAvailable: Bool)
}

class NetworkHelper {
    
    static let shared = NetworkHelper()
    
    private var reachability: SCNetworkReachability?
    weak var delegate: NetworkStatusDelegate?
    
    private init() {
        self.reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com")
    }
    
    // MARK: - Reachability section -
    
    func startMonitoringNetworkStatus() {
        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        context.info = UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
        
        if let reachability = reachability,
           SCNetworkReachabilitySetCallback(reachability, { (reachability, flags, info) in
               if let info = info {
                   let networkManager = Unmanaged<NetworkHelper>.fromOpaque(info).takeUnretainedValue()
                   networkManager.networkStatusDidChange()
               }
           }, &context) {
            SCNetworkReachabilityScheduleWithRunLoop(reachability, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue)
        }
    }
    
    func stopMonitoringNetworkStatus() {
        if let reachability = reachability {
            SCNetworkReachabilityUnscheduleFromRunLoop(reachability, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue)
        }
    }
    
    func networkStatusDidChange() {
        self.delegate?.networkStatusDidChange(isAvailable: self.isNetworkAvailable())
    }
    
    private func isNetworkAvailable() -> Bool {
        var flags = SCNetworkReachabilityFlags()
        if let reachability = reachability {
            SCNetworkReachabilityGetFlags(reachability, &flags)
        }
        return flags.contains(.reachable) && !flags.contains(.connectionRequired)
    }
}
