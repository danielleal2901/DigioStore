//
//  CodableView.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation

protocol CodableView {
    func buildLayout()
    func setupViewHierarchy()
    func setupLayoutConstraints()
    func setupAdditionalConfiguration()
}

extension CodableView {
    func buildLayout() {
        setupViewHierarchy()
        setupLayoutConstraints()
        setupAdditionalConfiguration()
    }

    func setupAdditionalConfiguration() {}
}
