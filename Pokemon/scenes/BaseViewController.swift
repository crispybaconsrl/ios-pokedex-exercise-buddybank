//
//  BaseViewController.swift
//  Pokemon
//
//  Created by Luca Davanzo on 23/05/23.
//

import UIKit

import PinLayout

protocol BaseViewControllerProtocol {
    static func instantiate() -> BaseViewController
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    // MARK: - Variables -
    
    weak var coordinator: PokemonCoordinator?
    var viewModel: BaseViewModel?
    lazy var noDataView: NoDataView = NoDataView()
    
    // MARK: - Layout lifecycle -
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = AppTheme.shared.colors.main
    }
    
    // MARK: - Class methods -
    
    static func instantiate() -> BaseViewController {
        let className = "\(Bundle.main.appName ?? "").\(String(describing: self))"
        if let viewControllerClass = NSClassFromString(className) as? BaseViewController.Type {
            return viewControllerClass.init()
        }
        return BaseViewController()
    }
    
    // MARK: - Public methods -
    
    func displayNoDataView(_ show: Bool) {
        self.view.subviews.forEach { $0.isHidden = show }
        self.noDataView.isHidden = !show
        if show {
            self.noDataView.attach(on: self.view)
        } else {
            self.noDataView.detach(from: self.view)
        }
    }
    
}
