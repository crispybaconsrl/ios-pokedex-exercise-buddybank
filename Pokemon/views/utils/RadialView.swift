//
//  RadialView.swift
//  Pokemon
//
//  Created by Luca Davanzo on 25/05/23.
//

import Foundation
import UIKit

class RadialGradientView: UIView {
    
    // MARK: - Private properties -
    
    private let shapeLayer = CAShapeLayer()
    
    // MARK: - Constructors -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View lifecycle -
    
    override func layoutSubviews() {
        self.setupLayers(radius: 26)
    }
    
    // MARK: - Private methods -
    
    private func setupLayers(radius: CGFloat) {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                                        radius: radius,
                                        startAngle: 0,
                                        endAngle: CGFloat.pi * 2,
                                        clockwise: true)
        
        self.shapeLayer.path = circularPath.cgPath
        self.shapeLayer.fillColor = UIColor.black.cgColor
        self.shapeLayer.strokeColor = UIColor.systemGreen.cgColor
        self.shapeLayer.lineWidth = 2
        self.shapeLayer.lineCap = CAShapeLayerLineCap.round

        self.addGradient()
    }
    
    private func addGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.white.cgColor, AppTheme.shared.colors.main.withAlphaComponent(0.2).cgColor]
        gradient.frame = bounds
        gradient.mask = shapeLayer
        layer.addSublayer(gradient)
    }
}
