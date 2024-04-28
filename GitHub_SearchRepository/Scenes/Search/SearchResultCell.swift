//
//  SearchResultCell.swift
//  GitHub_SearchRepository
//
//  Created by Satoshi Komatsu on 2024/04/25.
//

import UIKit

final class SearchResultCell: UICollectionViewListCell {
    private func defaultListContentConfiguration() -> UIListContentConfiguration { return .cell() }
    private lazy var listContentView = UIListContentView(configuration: defaultListContentConfiguration())

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(listContentView)
        listContentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            listContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            listContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            listContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            listContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            listContentView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    var title: String = ""

    override func updateConfiguration(using state: UICellConfigurationState) {
        var content = defaultContentConfiguration().updated(for: state)
        content.text = title
        listContentView.configuration = content

        guard let textLayoutGuide = listContentView.textLayoutGuide else { return }

        let constraint = separatorLayoutGuide.leadingAnchor.constraint(equalTo: textLayoutGuide.leadingAnchor)
        constraint.isActive = true
    }

    func setup(repository: Repository) {
        title = repository.fullName
    }
}

private class CustomLabel: UILabel {
    override var intrinsicContentSize: CGSize {
        CGSize(width: -1, height: 150)
    }
}
