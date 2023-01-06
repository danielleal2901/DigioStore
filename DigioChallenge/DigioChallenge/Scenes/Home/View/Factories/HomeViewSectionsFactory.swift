//
//  HomeViewSectionsFactory.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation
import UIKit

struct HomeSectionViewData {
    let numberOfSections: Int
    let numberOfRows: Int
    let sectionHeight: CGFloat
    let header: String?
    let cellForRowAtIndexpath: (_ indexPath: IndexPath, _ collectionView: UICollectionView) -> UICollectionViewCell
    let registerComponents: (_ collection: UICollectionView) -> Void
    let itemSelectedAtIndexpath: (_ indexPath: IndexPath) -> Void

    init(
        numberOfSections: Int,
        numberOfRows: Int,
        sectionHeight: CGFloat,
        header: String? = nil,
        cellForRowAtIndexpath: @escaping (_: IndexPath, _: UICollectionView) -> UICollectionViewCell,
        registerComponents: @escaping (_: UICollectionView) -> Void,
        itemSelectedAtIndexpath: @escaping (_ indexPath: IndexPath) -> Void
    ) {
        self.header = header
        self.numberOfSections = numberOfSections
        self.numberOfRows = numberOfRows
        self.cellForRowAtIndexpath = cellForRowAtIndexpath
        self.registerComponents = registerComponents
        self.sectionHeight = sectionHeight
        self.itemSelectedAtIndexpath = itemSelectedAtIndexpath
    }
}

struct HomeSectionsFactory {
    let make: () -> HomeSectionViewData
}

extension HomeSectionsFactory {
    static func spotlights(_ spotlights: [Spotlight], spotlightSelected: @escaping (SpotlightViewData) -> Void) -> Self {
        .init {
            let formattedSpotlights = spotlights.map {SpotlightViewData(spotlight: $0)}
            return .init(
                numberOfSections: 1,
                numberOfRows: formattedSpotlights.count,
                sectionHeight: 200
            ) { indexPath, collection in
                if let cell = collection.dequeueReusableCell(
                    withReuseIdentifier: HomeSpotlightCollectionViewCell.identifier,
                    for: indexPath
                ) as? HomeSpotlightCollectionViewCell {
                    if let spotlight = formattedSpotlights[safe: indexPath.row] {
                        cell.setup(with: spotlight)
                    }
                    return cell
                }
                return UICollectionViewCell()
            } registerComponents: { collection in
                collection.register(
                    HomeSpotlightCollectionViewCell.self,
                    forCellWithReuseIdentifier: HomeSpotlightCollectionViewCell.identifier
                )
            } itemSelectedAtIndexpath: { indexPath in
                guard let spotlight = formattedSpotlights[safe: indexPath.row] else { return }
                spotlightSelected(spotlight)
            }
        }
    }

    static func products(_ products: [Product], productSelected: @escaping (ProductViewData) -> Void) -> Self {
        .init {
            let formattedProducts = products.map {ProductViewData(product: $0)}
            return .init(
                numberOfSections: 1,
                numberOfRows: formattedProducts.count,
                sectionHeight: 140,
                header: "Produtos"
            ) { indexPath, collection in
                if let cell = collection.dequeueReusableCell(
                    withReuseIdentifier: HomeProductCollectionViewCell.identifier,
                    for: indexPath
                ) as? HomeProductCollectionViewCell {
                    if let product = formattedProducts[safe: indexPath.row] {
                        cell.setup(with: product)
                    }
                    return cell
                }
                return UICollectionViewCell()
            } registerComponents: { collection in
                collection.register(
                    HomeProductCollectionViewCell.self,
                    forCellWithReuseIdentifier: HomeProductCollectionViewCell.identifier
                )
            } itemSelectedAtIndexpath: { indexPath in
                guard let product = formattedProducts[safe: indexPath.row] else { return }
                productSelected(product)
            }
        }
    }

    static func cash(_ cash: Cash, cashSelected: @escaping (CashViewData) -> Void) -> Self {
        .init {
            .init(
                numberOfSections: 1,
                numberOfRows: 1,
                sectionHeight: 150,
                header: "digio Cash"
            ) { indexPath, collection in
                if let cell = collection.dequeueReusableCell(
                    withReuseIdentifier: HomeCashCollectionViewCell.identifier,
                    for: indexPath
                ) as? HomeCashCollectionViewCell {
                    cell.setup(with: CashViewData(cash: cash))
                    return cell
                }
                return UICollectionViewCell()
            } registerComponents: { collection in
                collection.register(
                    HomeCashCollectionViewCell.self,
                    forCellWithReuseIdentifier: HomeCashCollectionViewCell.identifier
                )
            } itemSelectedAtIndexpath: { _ in
                cashSelected(CashViewData(cash: cash))
            }
        }
    }
}
