//
//  HomeDetailViewController.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation
import UIKit

private extension HomeDetailViewController.Layout {
    enum Spacing {
        static let horizontalMarging = 20.0
    }
}

final class HomeDetailViewController: UIViewController {
    fileprivate enum Layout {}

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = detailData.title
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = detailData.description
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    private let detailData: HomeDetailViewData

    init(detailData: HomeDetailViewData) {
        self.detailData = detailData
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buildLayout()
        title = "Detalhes"
    }
}

extension HomeDetailViewController: CodableView {
    func setupViewHierarchy() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
    }

    func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.Spacing.horizontalMarging),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -Layout.Spacing.horizontalMarging)
        ])
    }

    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
    }
}
