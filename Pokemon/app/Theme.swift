//
//  Theme.swift
//  Pokemon
//
//  Created by Luca Davanzo on 25/05/23.
//

import Foundation
import UIKit

protocol Colors {
    var main: UIColor { get }
    var secondary: UIColor { get }
    var gray: UIColor { get }
}

protocol Theme {
    var margin: CGFloat { get }
    var colors: Colors { get }
}

class DefaultTheme: Theme {
    
    let margin: CGFloat = 10
    var colors: Colors
    
    init(colors: Colors) {
        self.colors = colors
    }
}

class DefaultColors: Colors {
    let main: UIColor = UIColor.systemPink
    let secondary: UIColor = UIColor.brown
    let gray: UIColor = UIColor.gray
}

class AppTheme {
    
    static var shared: any Theme = DefaultTheme(colors: DefaultColors())
    
    public func changeTheme(theme: any Theme) {
        AppTheme.shared = theme
    }
    
}
