//
//  PokemonCollectionHeaderView.swift
//  Pokemon
//
//  Created by Luca Davanzo on 25/05/23.
//

import Foundation
import UIKit

import PinLayout

class PokemonCollectionHeaderView: UICollectionReusableView {
    
    static let identifier = "PokemonCollectionHeaderViewIdentifier"
    static let height: CGFloat = 50
    
    let searchBar = UISearchBar()
    var searchBarDelegate: UISearchBarDelegate? {
        didSet {
            self.searchBar.delegate = self.searchBarDelegate
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.searchBar.searchBarStyle = .minimal
        self.searchBar.backgroundColor = .white
        self.addSubview(self.searchBar)
        self.searchBar.pin.all()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






