//
//  HomeTableHeaderView.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation
import UIKit

final class HomeTableHeaderView: UITableViewHeaderFooterView {
    static let identifier = String(describing: HomeTableHeaderView.self)

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .black)
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with title: String) {
        titleLabel.text = title
    }
}

extension HomeTableHeaderView: CodableView {
    func setupViewHierarchy() {
        addSubview(titleLabel)
    }

    func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
