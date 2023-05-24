//
//  BaseViewController.swift
//  Pokemon
//
//  Created by Luca Davanzo on 23/05/23.
//

import PinLayout

protocol BaseViewControllerProtocol {
    static func instantiate() -> BaseViewController
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    weak var coordinator: PokemonCoordinator?
    weak var viewModel: BaseViewModel?
    
    static func instantiate() -> BaseViewController {
        let className = "\(Bundle.main.appName ?? "").\(String(describing: self))"
        if let viewControllerClass = NSClassFromString(className) as? BaseViewController.Type {
            return viewControllerClass.init()
        }
        return BaseViewController()
    }
    
}
