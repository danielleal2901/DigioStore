//
//  Home.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation

struct Home: Decodable, Equatable {
    let spotlight: [Spotlight]
    let products: [Product]
    let cash: Cash
}
