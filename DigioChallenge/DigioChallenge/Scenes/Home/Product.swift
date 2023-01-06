//
//  Product.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation

struct Product: Decodable, Equatable {
    let name: String
    let imageURL: String
    let description: String
}
