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
    private var infoCollectionView: UICollectionView?
    
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
            self.nameLabel.text = details?.name.uppercased() ?? "No name"
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
    
    private func setupSpritesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = AppTheme.shared.margin
        layout.minimumLineSpacing = AppTheme.shared.margin
        layout.scrollDirection = .horizontal
        self.spritesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.spritesCollectionView!.backgroundColor = .clear
        self.spritesCollectionView!.delegate = self
        self.spritesCollectionView!.dataSource = self
        self.spritesCollectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "SpriteCell")
        self.addSubview(self.spritesCollectionView!)
    }
    
    private func setupInfoCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.infoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.infoCollectionView!.backgroundColor = .clear
        self.infoCollectionView!.delegate = self
        self.infoCollectionView!.dataSource = self
        self.infoCollectionView!.register(InfoCell.self, forCellWithReuseIdentifier: InfoCell.identifier)
        self.addSubview(self.infoCollectionView!)
    }
    
    private func setupViewsContraints() {
        self.nameLabel.pin
            .top(safeAreaInsets.top + AppTheme.shared.margin)
            .hCenter()
            .width(100%)
            .sizeToFit(.width)
        
        if let sprites = self.spritesCollectionView {
            sprites.pin
                .below(of: self.nameLabel)
                .marginTop(AppTheme.shared.margin)
                .horizontally(AppTheme.shared.margin)
                .height(100)
            if let info = self.infoCollectionView {
                info.pin
                    .below(of: sprites)
                    .marginTop(AppTheme.shared.margin)
                    .horizontally(AppTheme.shared.margin)
                    .bottom()
            }
        }
        
        self.layoutIfNeeded()
    }
    
    private func setupUI() {
        self.setupNameLabel()
        self.setupSpritesCollectionView()
        self.setupInfoCollectionView()
        self.setupViewsContraints()
    }
    
}

extension PokemonDetailsView: UICollectionViewDelegate {
    
}

extension PokemonDetailsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView === self.spritesCollectionView) {
            return self.sprites.count
        }
        switch section {
        case 0: return self.details?.getStatisticNames().count ?? 0
        case 1: return self.details?.getTypeNames().count ?? 0
        default: return 0
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (collectionView === self.spritesCollectionView) {
            return 1
        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView === self.spritesCollectionView) {
            return self.createImageCell(at: indexPath)
        }
        switch indexPath.section {
        case 0: return self.createStatisticCell(at: indexPath)
        case 1: return self.createTypeCell(at: indexPath)
        default: return self.spritesCollectionView!.dequeueReusableCell(withReuseIdentifier: "SpriteCell", for: indexPath)
        }
    }
    
    private func createImageCell(at index: IndexPath) -> UICollectionViewCell {
        let cell = self.spritesCollectionView!.dequeueReusableCell(withReuseIdentifier: "SpriteCell", for: index)
        let spriteURL = self.sprites[index.item]
        
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
    
    private func createStatisticCell(at index: IndexPath) -> UICollectionViewCell {
        let text = self.details?.getStatisticNames()[index.item]
        return self.createInfoCell(at: index, with: text)
    }
    
    private func createTypeCell(at index: IndexPath) -> UICollectionViewCell {
        let text = self.details?.getTypeNames()[index.item]
        return self.createInfoCell(at: index, with: text)
    }
    
    private func createInfoCell(at index: IndexPath, with text: String?) -> UICollectionViewCell {
        let cell = self.infoCollectionView!.dequeueReusableCell(withReuseIdentifier: InfoCell.identifier, for: index)
        if let infoCell = cell as? InfoCell {
            infoCell.setup(title: text?.capitalized ?? "-")
        }
        return cell
    }
    
}

extension PokemonDetailsView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGFloat = 60
        if (collectionView === self.spritesCollectionView) {
            return CGSize(width: size, height: size)
        }
        let width = self.bounds.width - 2 * AppTheme.shared.margin
 
        return CGSize(width: width, height: size / 2)
    }
    
}
