//
//  EmptyCollectionViewCell.swift
//  Pokemon
//
//  Created by Luca Davanzo on 29/05/23.
//

import Foundation
import UIKit

import PinLayout

class EmptyCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Class properties -
    
    static let identifier = "EmptyCollectionViewCellIdentifier"
    
    // MARK: - Private properties -
    
    private lazy var emptyView: NoDataView = NoDataView()
    
    // MARK: - Constructors -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    // MARK: - Public methods -
    
    func setupTitle(_ text: String) {
        self.emptyView.setupTitle(text)
    }
    
    // MARK: - Private methods -
    
    private func setupUI() {
        self.emptyView.attach(on: self)
        self.emptyView.pin.all()
    }
    
}
