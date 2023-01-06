//
//  HomeCoordinator.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation
import UIKit

protocol HomeCoordinatorProtocol {
    func openDetail(with data: HomeDetailViewData)
}

final class HomeCoordinator {
    private let navigationController: UINavigationController

    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension HomeCoordinator: HomeCoordinatorProtocol {
    func openDetail(with data: HomeDetailViewData) {
        let detail = createDetail(with: data)
        navigationController.pushViewController(detail, animated: true)
    }
}

private extension HomeCoordinator {
    func createDetail(with data: HomeDetailViewData) -> HomeDetailViewController {
        let homeDetailController = HomeDetailViewController(detailData: data)
        return homeDetailController
    }
}
