//
//  NoDataView.swift
//  Pokemon
//
//  Created by Luca Davanzo on 24/05/23.
//

import Foundation
import UIKit

import PinLayout

class NoDataView: UIView {
    
    // MARK: - Private properties -
    
    private var label: UILabel = UILabel()
    
    // MARK: - Constructors -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public methods -
    
    override func attach(on parent: UIView) {
        super.attach(on: parent)
        self.pin.all()
        self.setupView()
    }
    
    func setupTitle(_ text: String) {
        self.label.text = text
    }
    
    // MARK: - Private methods -
    
    private func setupView() {
        self.addSubview(self.label)
        self.label.font = UIFont.systemFont(ofSize: 20)
        self.label.text = "No data available"
        self.label.textColor = AppTheme.shared.colors.secondary
        self.label.textAlignment = .center
        self.label.numberOfLines = 32
        
        self.label.pin
            .all()
            .margin(AppTheme.shared.margin * 2)
            .wrapContent(.vertically)
    }
}

