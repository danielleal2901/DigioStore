//
//  HomeService.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation

struct HomeEndpoint: Endpoint {
    let path: String = "sandbox/products"
}

protocol HomeServiceProtocol {
    func getHome(completion: @escaping (Result<Home, NetworkError>) -> Void)
}

final class HomeService: HomeServiceProtocol {
    private let network: NetworkProtocol

    init(network: NetworkProtocol = NetworkClient()) {
        self.network = network
    }

    func getHome(completion: @escaping (Result<Home, NetworkError>) -> Void) {
        let endpoint = HomeEndpoint()
        network.makeRequest(endpoint: endpoint) { (result: Result<Home, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case let .success(model):
                    completion(.success(model))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
}
