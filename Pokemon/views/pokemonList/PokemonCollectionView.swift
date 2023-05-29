//
//  PokemonCollectionView.swift
//  Pokemon
//
//  Created by Luca Davanzo on 25/05/23.
//

import Foundation
import UIKit

import PinLayout

class PokemonCollectionView: UICollectionView {
    
    // MARK: - Constructors -
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.registerRelatedCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods -
    
    func getCell(at index: IndexPath) -> PokemonCollectionViewCell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: index) as? PokemonCollectionViewCell else {
            fatalError("Unable to dequeue PokemonCollectionViewCell")
        }
    
        return cell
    }
    
    override func attach(on parent: UIView) {
        super.attach(on: parent)
    }
    
    // MARK: - Private methods -
    
    private func registerRelatedCell() {
        self.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
    }
    
}

