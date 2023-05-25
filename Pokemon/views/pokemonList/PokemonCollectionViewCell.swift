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
    private var textLabel: UILabel?
    private let radialGradientView = RadialGradientView()
    
    // MARK: - Constructors -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupRadialGradientView()
        self.setupImageView()
        self.setupTextLabel()
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
        self.imageView?.pin.all().margin(20)
    }
    
    private func setupTextLabel() {
        self.textLabel = UILabel()
        self.textLabel?.textAlignment = .center
        self.textLabel?.textColor = .gray
        self.textLabel?.font = UIFont.systemFont(ofSize: 16)
        self.textLabel?.numberOfLines = 1
        self.addSubview(self.textLabel!)
        self.textLabel?.pin
            .below(of: self.imageView!)
            .bottom()
            .left()
            .right()
            .marginTop(6)
            .height(20)
        self.bringSubviewToFront(textLabel!)
    }
    
    // MARK: - Public methods -
    
    func setup(with pokemon: Pokemon) {
        self.textLabel?.text = pokemon.name.capitalized
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
