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

        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false

        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        title.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let title: CustomLabel = {
        let label = CustomLabel()
        return label
    }()

    func setup(name: String) {
        title.text = name
    }
}

private class CustomLabel: UILabel {
    override var intrinsicContentSize: CGSize {
        CGSize(width: -1, height: 150)
    }
}
