//
//  PokemonCollectionView.swift
//  Pokemon
//
//  Created by Luca Davanzo on 25/05/23.
//

import Foundation
import UIKit

import PinLayout

class PokemonCollectionView: RefreshableCollectioView {
    
    // MARK: - Constructors -
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.registerRelatedCells()
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
    
    func getEmptyCell(at index: IndexPath) -> EmptyCollectionViewCell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: EmptyCollectionViewCell.identifier, for: index) as? EmptyCollectionViewCell else {
            fatalError("Unable to dequeue PokemonCollectionViewCell")
        }
        return cell
    }
    
    override func attach(on parent: UIView) {
        super.attach(on: parent)
    }
    
    // MARK: - Private methods -
    
    private func registerRelatedCells() {
        self.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        self.register(EmptyCollectionViewCell.self, forCellWithReuseIdentifier: EmptyCollectionViewCell.identifier)
    }
    
}

