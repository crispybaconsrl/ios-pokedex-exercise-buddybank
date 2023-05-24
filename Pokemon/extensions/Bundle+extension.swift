//
//  Bundle+extension.swift
//  Pokemon
//
//  Created by Luca Davanzo on 23/05/23.
//

import Foundation

extension Bundle {
    var appName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
                     object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}
