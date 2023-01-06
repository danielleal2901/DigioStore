//
//  HomeFixtures.swift
//  DigioChallengeTests
//
//  Created by Daniel Leal on 06/01/23.
//

import Foundation
@testable import DigioChallenge

extension Product {
    static func fixture(
        name: String = "Product",
        imageURL: String = "url.com",
        description: String = "description"
    ) -> Self {
        .init(name: name, imageURL: imageURL, description: description)
    }
}

extension Cash {
    static func fixture(
        title: String = "Cash",
        bannerURL: String = "url.com",
        description: String = "description"
    ) -> Self {
        .init(title: title, bannerURL: bannerURL, description: description)
    }
}

extension Spotlight {
    static func fixture(
        name: String = "Spotlight",
        bannerURL: String = "url.com",
        description: String = "description"
    ) -> Self {
        .init(name: name, bannerURL: bannerURL, description: description)
    }
}

extension Home {
    static func fixture(
        products: [Product] = [.fixture()],
        spotlight: [Spotlight] = [.fixture()],
        cash: Cash = .fixture()
    ) -> Self {
        .init(spotlight: spotlight, products: products, cash: cash)
    }
}

extension ProductViewData {
    static func fixture(_ product: Product = .fixture()) -> Self {
        .init(product: product)
    }
}

extension SpotlightViewData {
    static func fixture(_ spotlight: Spotlight = .fixture()) -> Self {
        .init(spotlight: spotlight)
    }
}

extension CashViewData {
    static func fixture(_ cash: Cash = .fixture()) -> Self {
        .init(cash: cash)
    }
}

extension HomeDetailViewData {
    static func fixture(
        type: DetailType = .product(data: .fixture())
    ) -> Self {
        .init(type: type)
    }
}
