//
//  InfoCell.swift
//  Pokemon
//
//  Created by Luca Davanzo on 25/05/23.
//

import Foundation
import UIKit

import PinLayout

class InfoCell: UICollectionViewCell {
    
    // MARK: - Class properties -
    
    static let identifier = "InfoCellIdentifier"
    
    // MARK: - Private properties -
    
    private let gradientLayer = CAGradientLayer()
    private let textLabel = UILabel()
    
    // MARK: - Constructors -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupGradientLayer()
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupGradientLayer()
    }
    
    // MARK: - Lifecycle -
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer.frame = bounds
    }
    
    // MARK: - Public methods -
    
    func setup(title: String) {
        self.textLabel.text = title
    }
    
    // MARK: - Private methods -
    
    private func setupUI() {
        self.addSubview(self.textLabel)
        self.textLabel.textColor = .white
        self.textLabel.pin.all().marginLeft(AppTheme.shared.margin)
    }
    
    private func setupGradientLayer() {
        let startColor = UIColor.systemPink.withAlphaComponent(0.4).cgColor
        let endColor = UIColor.white.cgColor
        self.gradientLayer.colors = [startColor, endColor]

        self.gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        self.gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)

        self.layer.addSublayer(self.gradientLayer)
    }
    
}
