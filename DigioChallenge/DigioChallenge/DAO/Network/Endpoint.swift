//
//  Endpoint.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation

enum Method: String {
    case get = "GET"
}

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var method: Method { get }
    var parameters: [String] { get }
    var headers: [String: Any] { get }
}

extension Endpoint {
    var baseUrl: String {
        "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/"
    }

    var method: Method {
        .get
    }

    var parameters: [String] {
        []
    }

    var headers: [String: Any] {
        [:]
    }
}
