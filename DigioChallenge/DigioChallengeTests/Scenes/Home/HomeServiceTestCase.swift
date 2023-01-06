//
//  HomeServiceTestCase.swift
//  DigioChallengeTests
//
//  Created by Daniel Leal on 06/01/23.
//

import XCTest
@testable import DigioChallenge

final class HomeServiceTestCase: XCTestCase {
    fileprivate typealias Sut = (service: HomeService, network: NetworkMock<Home>)

    // MARK: GetHome
    func testGetHome_whenResultIsError_shouldReceiveError() {
        let sut = makeSut()
        let expectedResult: Result<Home, NetworkError> = .failure(.unknown)
        sut.network.result = expectedResult

        sut.service.getHome { result in
            XCTAssertEqual(expectedResult, result)
        }
    }

    func testGetHome_whenResultIsSuccess_shouldReceiveSuccess() {
        let sut = makeSut()
        let expectedResult: Result<Home, NetworkError> = .success(.fixture())
        sut.network.result = expectedResult

        sut.service.getHome { result in
            XCTAssertEqual(expectedResult, result)
        }
    }
}

private extension HomeServiceTestCase {
    func makeSut() -> Sut {
        let network = NetworkMock<Home>()
        let service = HomeService(network: network)
        return (service, network)
    }
}
