//
//  HomeViewModelTestCase.swift
//  DigioChallengeTests
//
//  Created by Daniel Leal on 06/01/23.
//

import XCTest
@testable import DigioChallenge

private final class HomeCoordinatorSpy: HomeCoordinatorProtocol {
    var openDetailCallsCount = 0
    var openDetailData: HomeDetailViewData?

    func openDetail(with data: DigioChallenge.HomeDetailViewData) {
        openDetailCallsCount += 1
        openDetailData = data
    }
}

private final class HomeViewControllerSpy: HomeViewControllerProtocol {
    var showHomeCallsCount = 0
    var showHomeData: Home?
    var showLoadingCallsCount = 0
    var showErrorCallsCount = 0
    var removeLoadingCallsCount = 0

    func showHome(_ home: DigioChallenge.Home) {
        showHomeCallsCount += 1
        showHomeData = home
    }

    func showLoading() {
        showLoadingCallsCount += 1
    }

    func showError() {
        showErrorCallsCount += 1
    }

    func removeLoading() {
        removeLoadingCallsCount += 1
    }
}

final class HomeViewModelTestCase: XCTestCase {
    fileprivate typealias Sut = (
        viewModel: HomeViewModel,
        coordinator: HomeCoordinatorSpy,
        viewController: HomeViewControllerSpy,
        service: HomeServiceMock
    )

    // MARK: Load Home
    func testLoadHome_whenResultIsError_shouldShowLoadingAndShowError() {
        let sut = makeSut()
        sut.service.result = .failure(.malformedRequest)

        sut.viewModel.loadHome()

        XCTAssertEqual(sut.viewController.showLoadingCallsCount, 1)
        XCTAssertEqual(sut.viewController.showErrorCallsCount, 1)
    }

    func testLoadHome_whenResultIsSuccess_shouldShowLoadingAndShowError() {
        let sut = makeSut()
        let expectedHome: Home = .fixture()
        sut.service.result = .success(.fixture())

        sut.viewModel.loadHome()

        XCTAssertEqual(sut.viewController.showLoadingCallsCount, 1)
        XCTAssertEqual(sut.viewController.showHomeData, expectedHome)
    }

    // MARK: SpotlightSelected
    func testSpotlightSelected_shouldShowOpenDetail() {
        let sut = makeSut()
        let spotlightData: SpotlightViewData = .fixture()
        let expectedData: HomeDetailViewData = .fixture(type: .spotlight(data: spotlightData))

        sut.viewModel.spotlightSelected(spotlightData)

        XCTAssertEqual(sut.coordinator.openDetailCallsCount, 1)
        XCTAssertEqual(sut.coordinator.openDetailData, expectedData)
    }

    // MARK: ProductSelected
    func testProductSelected_shouldShowOpenDetail() {
        let sut = makeSut()
        let productData: ProductViewData = .fixture()
        let expectedData: HomeDetailViewData = .fixture(type: .product(data: productData))

        sut.viewModel.productSelected(productData)

        XCTAssertEqual(sut.coordinator.openDetailCallsCount, 1)
        XCTAssertEqual(sut.coordinator.openDetailData, expectedData)
    }

    // MARK: ProductSelected
    func testCashSelected_shouldShowProductSelected() {
        let sut = makeSut()
        let cashData: CashViewData = .fixture()
        let expectedData: HomeDetailViewData = .fixture(type: .cash(data: cashData))

        sut.viewModel.cashSelected(cashData)

        XCTAssertEqual(sut.coordinator.openDetailCallsCount, 1)
        XCTAssertEqual(sut.coordinator.openDetailData, expectedData)
    }
}

private extension HomeViewModelTestCase {
    func makeSut() -> Sut {
        let coordinator = HomeCoordinatorSpy()
        let service = HomeServiceMock()
        let viewModel = HomeViewModel(coordinator: coordinator, service: service)
        let viewController = HomeViewControllerSpy()
        viewModel.controller = viewController

        return (viewModel, coordinator, viewController, service)
    }
}
