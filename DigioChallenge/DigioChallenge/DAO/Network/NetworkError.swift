//
//  NetworkError.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation

enum NetworkError: Error, Equatable {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case malformedRequest
    case unknown

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.transportError, .transportError):
            return true
        case (.serverError, .serverError):
            return true
        case (.noData, .noData):
            return true
        case (.decodingError, .decodingError):
            return true
        case (.malformedRequest, .malformedRequest):
            return true
        case (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
}

extension NetworkError {
    init?(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            self = .transportError(error)
            return
        }

        if let response = response as? HTTPURLResponse,
            !(200...299).contains(response.statusCode) {
            self = .serverError(statusCode: response.statusCode)
            return
        }

        if data == nil {
            self = .noData
        }

        return nil
    }
}
