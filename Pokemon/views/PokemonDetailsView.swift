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
    private var details: PokemonDetail?
    private var sprites: [String] = []
    
    // TODO show: name, images, stats and type.
    
    // MARK: - Constructors -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Public methods -
    
    func setupWith(details: PokemonDetail?) {
        DispatchQueue.main.async {
            self.details = details
            if let object = self.details?.sprites.convertObjectToDictionary() {
                self.sprites = object.values.filter({$0 is String}) as! [String]
            }
            self.nameLabel.text = details?.name ?? "No name"
            self.statsLabel.text = details?.getStatisticNames().joined(separator: ",") ?? "-"
            self.typesLabel.text = details?.getTypeNames().joined(separator: ",") ?? "-"
            self.setupUI()
            self.spritesCollectionView?.reloadData()
        }
    }
    
    // MARK: - Private methods -
    
    private func setupNameLabel() {
        self.nameLabel.textAlignment = .center
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.nameLabel.textColor = .black
        self.addSubview(self.nameLabel)
    }
    
    private func setupStatisticsLabel() {
        self.statsLabel.numberOfLines = 0
        self.statsLabel.font = UIFont.systemFont(ofSize: 16)
        self.statsLabel.textColor = .black
        self.statsLabel.backgroundColor = .green
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sprites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpriteCell", for: indexPath)
        let spriteURL = self.sprites[indexPath.item]
        
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
        cell.backgroundColor = .red
        return cell
    }
    
    
}
