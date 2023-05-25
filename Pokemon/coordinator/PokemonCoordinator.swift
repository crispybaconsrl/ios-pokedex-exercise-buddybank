//
//  PokemonCoordinator.swift
//  Pokemon
//
//  Created by Luca Davanzo on 23/05/23.
//

import UIKit

class PokemonCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public methods -
    
    func start() {
        self.showViewController(PokemonListViewController.self, PokemonListViewModel.self)
    }
    
    func showDetails() {
        self.showViewController(PokemonDetailsViewController.self, PokemonDetailsViewModel.self)
    }
    
    // MARK: - Private methods -
    
    func showViewController(_ viewControllerType: BaseViewController.Type, _ viewModelType: BaseViewModel.Type) {
        let viewController = viewControllerType.instantiate()
        viewController.coordinator = self
        viewController.viewModel = viewModelType.instantiate()
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}

