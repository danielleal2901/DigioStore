//
//  HomeViewController.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation
import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func showHome(_ home: Home)
    func showLoading()
    func showError()
    func removeLoading()
}

private extension HomeViewController.Layout {
    enum Spacing {
        static let horizontalMarging = 20.0
    }
    enum Size {
        static let sectionsAverageHeight = 150.0
        static let headerHeight = 50.0
    }
}

final class HomeViewController: UIViewController {
    fileprivate enum Layout {}

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = Layout.Size.sectionsAverageHeight
        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.register(HomeTableHeaderView.self, forHeaderFooterViewReuseIdentifier: HomeTableHeaderView.identifier)
        return tableView
    }()

    private let activityIndicator = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .gray
        return indicator
    }()

    private let viewModel: HomeViewModelProtocol
    private var homeFactory: HomeViewFactory? {
        didSet {
            tableView.reloadData()
        }
    }

    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buildLayout()
        viewModel.loadHome()
    }
}

extension HomeViewController: CodableView {
    func setupViewHierarchy() {
        view.addSubview(activityIndicator)
        view.addSubview(tableView)
    }

    func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.Spacing.horizontalMarging),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.Spacing.horizontalMarging),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        title = "Digio Store"
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        homeFactory?.numberOfSections ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeFactory?.rows ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell,
              let sectionFactory = homeFactory?.sectionFactories[safe: indexPath.section]
        else { return UITableViewCell() }

        cell.setup(with: sectionFactory.make())
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let title = homeFactory?.headerForSection(section),
              let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeTableHeaderView.identifier) as? HomeTableHeaderView
        else {
            return nil
        }

        header.setup(with: title)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        homeFactory?.headerForSection(section) == nil ? .zero : Layout.Size.headerHeight
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        homeFactory?.heightForSection(indexPath.section) ?? 0
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    func showHome(_ home: Home) {
        activityIndicator.stopAnimating()
        homeFactory = .default(home: home, delegate: self)
    }

    func showLoading() {
        activityIndicator.startAnimating()
    }

    func showError() {
        let alert = UIAlertController(title: "Erro", message: "Não foi possível carregar os dados.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tentar novamente", style: .default) { _ in
            self.viewModel.loadHome()
        })
        present(alert, animated: true)
    }

    func removeLoading() {
        activityIndicator.stopAnimating()
    }
}

extension HomeViewController: HomeViewFactoryDelegate {
    func spotlightSelected(_ spotlight: SpotlightViewData) {
        viewModel.spotlightSelected(spotlight)
    }

    func productSelected(_ product: ProductViewData) {
        viewModel.productSelected(product)
    }

    func cashSelected(_ cash: CashViewData) {
        viewModel.cashSelected(cash)
    }
}
