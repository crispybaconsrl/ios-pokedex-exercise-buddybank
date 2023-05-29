//
//  RefreshableCollectioView.swift
//  Pokemon
//
//  Created by Luca Davanzo on 29/05/23.
//

import Foundation
import UIKit

protocol RefreshableCollectioViewDelegate {
    func refreshNeeded()
}

class RefreshableCollectioView: UICollectionView {
    
    // MARK: - Private properties -
    
    lazy private var refresh = UIRefreshControl()
    
    // MARK: - Public properties -
    
    var refreshDelegate: RefreshableCollectioViewDelegate?
    
    // MARK: - View lifecycle -
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.setupRefresh()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupRefresh()
    }
    
    // MARK: - Private methods -

    private func setupRefresh() {
        self.refresh.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        self.alwaysBounceVertical = true
        self.addSubview(self.refresh)
    }
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        self.refresh.beginRefreshing()
        self.refreshDelegate?.refreshNeeded()
        self.refresh.endRefreshing()
    }
}
