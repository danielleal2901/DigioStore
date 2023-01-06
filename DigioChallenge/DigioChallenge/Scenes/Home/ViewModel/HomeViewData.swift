//
//  HomeViewData.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation

struct ProductViewData {
    private let product: Product

    var bannerImage: URL? {
        URL(string: product.imageURL)
    }

    var title: String {
        product.name
    }

    var description: String {
        product.description
    }

    init(product: Product) {
        self.product = product
    }
}

struct SpotlightViewData {
    private let spotlight: Spotlight

    var bannerImage: URL? {
        URL(string: spotlight.bannerURL)
    }

    var title: String {
        spotlight.name
    }

    var description: String {
        spotlight.description
    }

    init(spotlight: Spotlight) {
        self.spotlight = spotlight
    }
}

struct CashViewData {
    private let cash: Cash

    var bannerImage: URL? {
        URL(string: cash.bannerURL)
    }

    var title: String {
        cash.title
    }

    var description: String {
        cash.description
    }

    init(cash: Cash) {
        self.cash = cash
    }
}
