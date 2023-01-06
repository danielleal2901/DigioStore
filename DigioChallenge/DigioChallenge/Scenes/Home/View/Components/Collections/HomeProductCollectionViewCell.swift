//
//  HomeProductCollectionViewCell.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation
import UIKit

private extension HomeProductCollectionViewCell.Layout {
    enum Size {
        static let imageContainer: CGSize = .init(width: 120, height: 120)
        static let imageView: CGSize = .init(width: 50, height: 50)
    }
}

final class HomeProductCollectionViewCell: HomeCollectionViewCell {
    fileprivate enum Layout {}
    static let identifier = String(describing: HomeProductCollectionViewCell.self)

    private let imageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    func setup(with content: ProductViewData) {
        guard let url = content.bannerImage else { return }
        imageView.getImageFrom(url: url, placeholder: UIImage(named: "imagePlaceholder"))
    }

    override func setupViewHierarchy() {
        contentView.addSubview(imageContainer)
        imageContainer.addSubview(imageView)
    }

    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageContainer.widthAnchor.constraint(equalToConstant: Layout.Size.imageContainer.width),
            imageContainer.heightAnchor.constraint(equalToConstant: Layout.Size.imageContainer.height)
        ])

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Layout.Size.imageView.width),
            imageView.heightAnchor.constraint(equalToConstant: Layout.Size.imageView.height)
        ])
    }

    override func setupAdditionalConfiguration() {
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowColor = UIColor.black.cgColor
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
    }
}
