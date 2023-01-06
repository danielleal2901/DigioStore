//
//  HomeViewFactory.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation
import UIKit

protocol HomeViewFactoryDelegate: AnyObject {
    func spotlightSelected(_ spotlight: SpotlightViewData)
    func productSelected(_ product: ProductViewData)
    func cashSelected(_ cash: CashViewData)
}

struct HomeViewFactory {
    let rows: Int
    let sectionFactories: [HomeSectionsFactory]
    let heightForSection: ((_ section: Int) -> CGFloat)
    let headerForSection: ((_ section: Int) -> String?)

    init(
        rows: Int = 1,
        sectionFactories: [HomeSectionsFactory],
        heightForSection: @escaping ((_: Int) -> CGFloat),
        headerForSection: @escaping ((_: Int) -> String?)
    ) {
        self.rows = rows
        self.sectionFactories = sectionFactories
        self.headerForSection = headerForSection
        self.heightForSection = heightForSection
    }
}

extension HomeViewFactory {
    var numberOfSections: Int {
        sectionFactories.count
    }
}

extension HomeViewFactory {
    static func `default`(home: Home, delegate: HomeViewFactoryDelegate) -> Self {
        let sections: [HomeSectionsFactory] = [
            .spotlights(home.spotlight, spotlightSelected: delegate.spotlightSelected(_:)),
            .cash(home.cash, cashSelected: delegate.cashSelected(_:)),
            .products(home.products, productSelected: delegate.productSelected(_:))
        ]

        return .init(sectionFactories: sections) { section in
            sections[section].make().sectionHeight
        } headerForSection: { section in
            sections[section].make().header
        }
    }
}
