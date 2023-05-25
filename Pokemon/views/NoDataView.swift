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
    
    private var textView: UITextView?;
    
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
        self.pin
            .topLeft(to: parent.anchor.topLeft)
            .topRight(to: parent.anchor.topRight)
            .bottomRight(to: parent.anchor.bottomRight)
            .bottomLeft(to: parent.anchor.bottomLeft)
        self.setupView()
    }
    
    
    // MARK: - Private methods -
    
    private func setupView() {
        if (self.textView == nil) {
            self.textView = UITextView()
            self.addSubview(self.textView!)
            self.textView?.font = UIFont.systemFont(ofSize: 20)
            self.textView?.text = "No data available"
            self.textView?.textColor = .black
            self.textView?.textAlignment = .center
            self.textView?.pin
                .top(100)
                .height(80)
                .left(to: self.edge.left)
                .right(to: self.edge.right)
                .margin(20)
            self.textView?.backgroundColor = .yellow
        }

    }
}

