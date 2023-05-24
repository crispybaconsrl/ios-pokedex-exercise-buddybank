//
//  BaseViewModel.swift
//  Pokemon
//
//  Created by Luca Davanzo on 23/05/23.
//

import Foundation

class BaseViewModel: NSObject {
    
    required override init() {
    }
    
    static func instantiate() -> BaseViewModel {
        let className = "\(Bundle.main.appName ?? "").\(String(describing: self))"
        if let viewModelClass = NSClassFromString(className) as? BaseViewModel.Type {
            return viewModelClass.init()
        }
        return BaseViewModel()
    }
}
