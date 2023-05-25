//
//  PokemonDetailsView.swift
//  Pokemon
//
//  Created by Luca Davanzo on 25/05/23.
//

import Foundation
import UIKit

import PinLayout

class PokemonDetailsView: UIView {
    
    // MARK: - Private properties -
    
    private let nameLabel = UILabel()
    private var spritesCollectionView: UICollectionView?
    private let statsLabel = UILabel()
    private let typesLabel = UILabel()
    
    // TODO show: name, images, stats and type.
    
    // MARK: - Constructors -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //        self.setupUI()
    }
    
    // MARK: - Public methods -
    
    func setupWith(pokemon: PokemonDetail?) {
        self.nameLabel.text = "pokemon.name"
        self.statsLabel.text = "pokemon.getStatisticNames"
        self.typesLabel.text = "pokemon.getTypeNames"
        self.backgroundColor = .green
        self.setupUI()
        //        self.layoutIfNeeded()
    }
    
    // MARK: - Private methods -
    
    private func setupNameLabel() {
        self.nameLabel.textAlignment = .center
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.addSubview(self.nameLabel)
    }
    
    private func setupStatisticsLabel() {
        self.statsLabel.numberOfLines = 0
        self.statsLabel.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(self.statsLabel)
    }
    
    private func setupTypesLabel() {
        self.typesLabel.numberOfLines = 0
        self.typesLabel.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(self.typesLabel)
    }
    
    private func setupSpritesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        self.spritesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.spritesCollectionView!.backgroundColor = .clear
        self.spritesCollectionView!.delegate = self
        self.spritesCollectionView!.dataSource = self
        self.spritesCollectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "SpriteCell")
        self.addSubview(self.spritesCollectionView!)
    }
    
    private func setupViewsContraints() {
        self.nameLabel.pin
            .top(safeAreaInsets.top + 16)
            .hCenter()
            .width(100%)
            .sizeToFit(.width)
        
        self.statsLabel.pin
            .marginTop(16)
            .horizontally(16)
            .sizeToFit(.width)
        
        if let sprites = self.spritesCollectionView {
            sprites.pin
                .below(of: nameLabel)
                .marginTop(16)
                .horizontally(16)
                .height(100)
            
            self.statsLabel.pin
                .below(of: sprites)
        }
        
        self.typesLabel.pin
            .below(of: statsLabel)
            .marginTop(16)
            .horizontally(16)
            .sizeToFit(.width)
        
        self.layoutIfNeeded()
    }
    
    private func setupUI() {
        self.nameLabel.text = "pokemon.name"
        self.statsLabel.text = "pokemon.getStatisticNames"
        self.typesLabel.text = "pokemon.getTypeNames"
        
        self.setupNameLabel()
        self.setupSpritesCollectionView()
        self.setupStatisticsLabel()
        self.setupTypesLabel()
        self.setupViewsContraints()
    }
    
}

extension PokemonDetailsView: UICollectionViewDelegate {
    
}

extension PokemonDetailsView: UICollectionViewDataSource {
    
    static var x = 1;
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpriteCell", for: indexPath)
        
        let spriteURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(PokemonDetailsView.x).png"
        PokemonDetailsView.x += 1;
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.frame = cell.contentView.bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cell.addSubview(imageView)
        imageView.pin.all()
        Task {
            if let image = await Downloader.shared.downloadImage(with: spriteURL) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
        return cell
    }
    
    
}
