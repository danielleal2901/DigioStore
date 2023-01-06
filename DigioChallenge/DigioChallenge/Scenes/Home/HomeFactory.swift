//
//  HomeFactory.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation
import UIKit

enum HomeFactory {
    static func make(with navigation: UINavigationController) -> UIViewController {
        let coordinator = HomeCoordinator(with: navigation)
        let service = HomeService()
        let viewModel = HomeViewModel(coordinator: coordinator, service: service)
        let controller = HomeViewController(viewModel: viewModel)

        viewModel.controller = controller
        return controller
    }
}
