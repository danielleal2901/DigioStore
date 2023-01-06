//
//  NetworkMock.swift
//  DigioChallengeTests
//
//  Created by Daniel Leal on 06/01/23.
//

import Foundation
@testable import DigioChallenge

final class NetworkMock<E>: NetworkProtocol {
    var result: Result<E, NetworkError>?

    func makeRequest<T>(endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) where T: Decodable {
        completion(result as? Result<T, NetworkError> ?? .failure(.unknown))
    }

    func cancel() {}
}
