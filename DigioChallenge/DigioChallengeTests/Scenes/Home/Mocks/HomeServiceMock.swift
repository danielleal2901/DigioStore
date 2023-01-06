//
//  HomeServiceMock.swift
//  DigioChallengeTests
//
//  Created by Daniel Leal on 06/01/23.
//

@testable import DigioChallenge

final class HomeServiceMock: HomeServiceProtocol {
    var result: Result<Home, NetworkError>?

    func getHome(completion: @escaping (Result<DigioChallenge.Home, DigioChallenge.NetworkError>) -> Void) {
        completion(result ?? .failure(.unknown))
    }
}
