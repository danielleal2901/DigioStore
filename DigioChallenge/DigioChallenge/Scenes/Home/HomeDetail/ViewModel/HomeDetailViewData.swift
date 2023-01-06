//
//  HomeDetailViewData.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation

struct HomeDetailViewData: Equatable {
    enum DetailType {
        case product(data: ProductViewData)
        case spotlight(data: SpotlightViewData)
        case cash(data: CashViewData)
    }

    let type: DetailType

    var title: String {
        switch type {
        case let .product(product):
            return "Produto: \(product.title)"
        case let .spotlight(spotlight):
            return "Spotlight: \(spotlight.title)"
        case let .cash(cash):
            return cash.title
        }
    }

    var description: String {
        switch type {
        case let .product(product):
            return product.description
        case let .spotlight(spotlight):
            return spotlight.description
        case let .cash(cash):
            return cash.description
        }
    }

    static func == (lhs: HomeDetailViewData, rhs: HomeDetailViewData) -> Bool {
        lhs.title == rhs.title &&
        lhs.description == rhs.description
    }
}
