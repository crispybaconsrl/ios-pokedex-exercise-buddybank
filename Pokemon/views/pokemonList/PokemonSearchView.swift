//
//  PokemonCollectionHeaderView.swift
//  Pokemon
//
//  Created by Luca Davanzo on 25/05/23.
//

import Foundation
import UIKit

import PinLayout

class PokemonSearchView: UISearchBar {
    
    var isFiltering: Bool {
        get {
            return !(self.text ?? "").isEmpty
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.searchBarStyle = .minimal
        self.backgroundColor = .white
        self.returnKeyType = .done
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
