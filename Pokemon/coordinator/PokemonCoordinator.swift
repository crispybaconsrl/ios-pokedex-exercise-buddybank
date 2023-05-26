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
    
    func showDetails(of pokemon: Pokemon) {
        let viewController = PokemonDetailsViewController.instantiate()
        viewController.coordinator = self
        viewController.viewModel = PokemonDetailsViewModel.instantiate()
        (viewController.viewModel as? PokemonDetailsViewModel)?.setup(with: pokemon)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Private methods -
    
    func showViewController(_ viewControllerType: BaseViewController.Type, _ viewModelType: BaseViewModel.Type) {
        let viewController = viewControllerType.instantiate()
        viewController.coordinator = self
        viewController.viewModel = viewModelType.instantiate()
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}

