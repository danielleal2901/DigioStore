//
//  HomeSpotlightCollectionViewCell.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation
import UIKit

private extension HomeSpotlightCollectionViewCell.Layout {
    enum Size {
        static let imageView: CGSize = .init(width: 300, height: 180)
    }
}

final class HomeSpotlightCollectionViewCell: HomeCollectionViewCell {
    fileprivate enum Layout {}
    static let identifier = String(describing: HomeSpotlightCollectionViewCell.self)

    func setup(with content: SpotlightViewData) {
        guard let url = content.bannerImage else { return }
        imageView.getImageFrom(url: url)
    }

    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()

        imageView.widthAnchor.constraint(equalToConstant: Layout.Size.imageView.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Layout.Size.imageView.height).isActive = true
    }

    override func setupAdditionalConfiguration() {
        backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        layer.masksToBounds = false
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
    }
}
