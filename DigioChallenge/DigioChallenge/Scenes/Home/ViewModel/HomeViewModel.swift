//
//  HomeViewModel.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation

protocol HomeViewModelProtocol {
    func loadHome()
    func spotlightSelected(_ spotlight: SpotlightViewData)
    func productSelected(_ product: ProductViewData)
    func cashSelected(_ cash: CashViewData)
}

final class HomeViewModel {
    private let service: HomeServiceProtocol
    private let coordinator: HomeCoordinatorProtocol?
    weak var controller: HomeViewControllerProtocol?

    init(
        coordinator: HomeCoordinatorProtocol,
        service: HomeServiceProtocol = HomeService()
    ) {
        self.coordinator = coordinator
        self.service = service
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    func loadHome() {
        controller?.showLoading()
        service.getHome { [weak self] result in
            switch result {
            case let .success(home):
                self?.controller?.showHome(home)
            case .failure:
                self?.controller?.showError()
            }
        }
    }

    func spotlightSelected(_ spotlight: SpotlightViewData) {
        coordinator?.openDetail(with: .init(type: .spotlight(data: spotlight)))
    }

    func productSelected(_ product: ProductViewData) {
        coordinator?.openDetail(with: .init(type: .product(data: product)))
    }

    func cashSelected(_ cash: CashViewData) {
        coordinator?.openDetail(with: .init(type: .cash(data: cash)))
    }
}
