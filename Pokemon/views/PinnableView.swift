//
//  PinnableView.swift
//  Pokemon
//
//  Created by Luca Davanzo on 25/05/23.
//

import Foundation
import UIKit

extension UIView {

    @objc
    func attach(on parent: UIView) {
        parent.addSubview(self)
    }

    @objc
    func detach(from parent: UIView) {
        if parent.subviews.contains(self) {
            self.removeFromSuperview()
        }
    }
    
}
