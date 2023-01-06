//
//  HomeCashCollectionViewCell.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation
import UIKit

private extension HomeCashCollectionViewCell.Layout {
    enum Size {
        static let imageView: CGSize = .init(width: 300, height: 130)
    }
}

final class HomeCashCollectionViewCell: HomeCollectionViewCell {
    fileprivate enum Layout {}
    static let identifier = String(describing: HomeSpotlightCollectionViewCell.self)

    func setup(with content: CashViewData) {
        guard let url = content.bannerImage else { return }
        imageView.getImageFrom(url: url)
    }

    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()

        imageView.widthAnchor.constraint(equalToConstant: Layout.Size.imageView.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Layout.Size.imageView.height).isActive = true
    }

    override func setupAdditionalConfiguration() {
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
    }
}
