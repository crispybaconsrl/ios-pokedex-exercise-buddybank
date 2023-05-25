//
//  Theme.swift
//  Pokemon
//
//  Created by Luca Davanzo on 25/05/23.
//

import Foundation

protocol Theme {
    var margin: CGFloat { get }
}

class DefaultTheme: Theme {
    let margin: CGFloat = 10
}

class AppTheme {
    
    static var shared: any Theme = DefaultTheme()
    
    public func changeTheme(theme: any Theme) {
        AppTheme.shared = theme
    }
    
}
