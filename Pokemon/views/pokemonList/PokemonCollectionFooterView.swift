//
//  PokemonCollectionFooterView.swift
//  Pokemon
//
//  Created by Luca Davanzo on 26/05/23.
//

import Foundation
import UIKit

class PokemonCollectionFooterView: UICollectionReusableView {
    
    // MARK: - Class properties -
    
    static let identifier = "PokemonCollectionFooterViewIdentifier"
    static let height: CGFloat = 50
    
    // MARK: - Private properties -
    
    private let loaderView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    // MARK: - Constructors -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLoaderView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupLoaderView()
    }
    
    // MARK: - Public methods -
    func startLoading() {
        self.loaderView.startAnimating()
    }
    
    func stopLoading() {
        self.loaderView.stopAnimating()
    }
    
    // MARK: - Private methods -
    
    private func setupLoaderView() {
        self.addSubview(self.loaderView)
        self.loaderView.hidesWhenStopped = false
        self.loaderView.pin.center().height(20).width(20)
    }
    
}
