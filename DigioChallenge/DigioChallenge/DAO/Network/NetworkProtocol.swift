//
//  NetworkProtocol.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation

protocol NetworkProtocol {
    func makeRequest<T: Decodable>(endpoint: Endpoint, completion: @escaping(Result<T, NetworkError>) -> Void)
    func cancel()
}

final class NetworkClient: NetworkProtocol {
    private let urlSession: URLSession
    private var currentTask: URLSessionDataTask?

    init(session: URLSession = .shared) {
        urlSession = session
    }

    func makeRequest<T>(endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) where T: Decodable {
        do {
            let request = try makeRequest(from: endpoint)
            currentTask = urlSession.dataTask(with: request) { data, response, error in
                if let networkError = NetworkError(data: data, response: response, error: error) {
                    completion(.failure(networkError))
                }
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
            currentTask?.resume()
        } catch let error as NetworkError {
            completion(.failure(error))
        } catch {
            completion(.failure(.unknown))
        }
    }

    func cancel() {
        currentTask?.cancel()
    }
}

private extension NetworkClient {
    func makeRequest(from endpoint: Endpoint) throws -> URLRequest {
        guard let url = URL(string: endpoint.baseUrl + endpoint.path)
        else { throw NetworkError.malformedRequest }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        return request
    }
}
