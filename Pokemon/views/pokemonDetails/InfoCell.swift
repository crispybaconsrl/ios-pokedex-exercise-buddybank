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
    private let detailsLabel = UILabel()
    
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
    
    func setup(title: String, detail: String = "") {
        self.textLabel.text = title
        self.detailsLabel.text = detail
    }
    
    // MARK: - Private methods -
    
    private func setupUI() {
        self.addSubview(self.textLabel)
        self.addSubview(self.detailsLabel)
        
        self.detailsLabel.textColor = AppTheme.shared.colors.gray
        self.detailsLabel.pin
            .top()
            .bottom()
            .right()
            .width(50)
            .marginRight(AppTheme.shared.margin * 2)
        
        self.textLabel.textColor = AppTheme.shared.colors.secondary
        self.textLabel.pin
            .top()
            .bottom()
            .left()
            .marginLeft(AppTheme.shared.margin)
            .left(of: self.detailsLabel)
            .marginRight(AppTheme.shared.margin)
        

        self.detailsLabel.textAlignment = .right
    }
    
    private func setupGradientLayer() {
        let startColor = AppTheme.shared.colors.main.withAlphaComponent(0.4).cgColor
        let endColor = UIColor.white.cgColor
        self.gradientLayer.colors = [startColor, endColor]
        
        self.gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        self.gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        self.layer.addSublayer(self.gradientLayer)
    }
    
}
