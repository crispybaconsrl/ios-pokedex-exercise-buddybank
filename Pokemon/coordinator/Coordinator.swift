//
//  Coordinator.swift
//  Pokemon
//
//  Created by Luca Davanzo on 23/05/23.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
