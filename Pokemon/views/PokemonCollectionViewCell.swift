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
    private let radialGradientView = RadialGradientView()
    
    // MARK: - Constructors -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupRadialGradientView()
        self.setupImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private methods -
    
    private func setupRadialGradientView() {
        self.addSubview(self.radialGradientView)
        self.radialGradientView.pin.all()
    }
    
    private func setupImageView() {
        self.imageView = UIImageView()
        self.addSubview(self.imageView!)
        self.imageView?.pin.all()
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
