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
    
    private var textView: UITextView = UITextView()
    
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
    
    // MARK: - Private methods -
    
    private func setupView() {
        self.addSubview(self.textView)
        self.textView.font = UIFont.systemFont(ofSize: 20)
        self.textView.text = "No data available"
        self.textView.textColor = AppTheme.shared.colors.secondary
        self.textView.textAlignment = .center
        self.textView.pin
            .vCenter()
            .hCenter()
            .sizeToFit()
            .margin(20)
    }
}

