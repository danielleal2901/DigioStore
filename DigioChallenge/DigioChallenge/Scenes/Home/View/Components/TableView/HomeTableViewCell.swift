//
//  HomeTableViewCell.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation
import UIKit

private extension HomeTableViewCell.Layout {
    enum Spacing {
        static let bottomMarging = 10.0
        static let spacingBetweenSections = 10.0
    }
}

final class HomeTableViewCell: UITableViewCell {
    fileprivate enum Layout {}
    static let identifier = String(describing: HomeTableViewCell.self)

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumLineSpacing = Layout.Spacing.spacingBetweenSections

        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceHorizontal = true
        return collection
    }()

    private var homeSection: HomeSectionViewData? {
        didSet {
            homeSection?.registerComponents(collectionView)
            updateCollection()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with section: HomeSectionViewData) {
        homeSection = section
    }
}

extension HomeTableViewCell: CodableView {
    func setupViewHierarchy() {
        contentView.addSubview(collectionView)
    }

    func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension HomeTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        homeSection?.numberOfSections ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeSection?.numberOfRows ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        homeSection?.cellForRowAtIndexpath(indexPath, collectionView) ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeSection?.itemSelectedAtIndexpath(indexPath)
    }
}

private extension HomeTableViewCell {
    func updateCollection() {
        collectionView.reloadData()
    }
}
