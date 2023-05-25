//
//  PokemonCollectionViewCell.swift
//  Pokemon
//
//  Created by Luca Davanzo on 25/05/23.
//

import Foundation
import UIKit

import PinLayout

class PokemonCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Class properties -
    
    static let identifier = "PokemonCollectionViewCellIdentifier"
    
    // MARK: - Private properties -
    
    private var imageView: UIImageView?
    
    // MARK: - Constructors -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        self.imageView = UIImageView()
        self.addSubview(self.imageView!)
        self.imageView?.pin.all()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Public methods -
    
    func setup(with pokemon: Pokemon) {
        if let imageUrl = pokemon.imageUrl {
            Task {
                if let image = await Downloader.shared.downloadImage(with: imageUrl) {
                    DispatchQueue.main.async {
                        self.imageView?.image = image
                    }
                }
            }
        }
    }
    
}
