//
//  SectionHeader.swift
//  Pokemon
//
//  Created by Luca Davanzo on 26/05/23.
//

import Foundation
import UIKit

import PinLayout

class SectionHeaderView: UICollectionReusableView {
    
    // MARK: - Class properties -
    
    static let identifier = "SectionHeaderViewIdentifier"
    
    // MARK: - Private properties -
    
    private var titleLabel: UILabel?
    
    // MARK: - Constructors -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private methods -
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.titleLabel = UILabel()
        self.addSubview(self.titleLabel!)
        self.titleLabel?.pin.all()
        self.titleLabel?.textAlignment = .left
        self.titleLabel?.textColor = .brown
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    // MARK: - Public methods -
    
    func setTitle(_ title: String) {
        self.titleLabel?.text = title
    }
    
}
