//
//  RepositoryViewController.swift
//  GitHub_SearchRepository
//
//  Created by satoshi on 2024/04/24.
//

import UIKit
import Combine

final class RepositoryDetailViewController: UIViewController {

    private let viewModel: RepositoryDetailViewModel

    private var cancellabled: Set<AnyCancellable> = []

    init(repository: Repository) {
        self.viewModel = RepositoryDetailViewModel(repository: repository, apiClient: APIClient())
        super.init(nibName: nil, bundle: nil)

        setViews()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private let textView: UITextView = {
        let view = UITextView()
        view.textColor = .black
        view.isEditable = false
        view.isScrollEnabled = true
        return view
    }()

    private lazy var starButton: UIButton = {
        let button = UIButton()
        button.setTitle("star", for: .normal)
        button.backgroundColor = .yellow
        button.addAction(.init { [weak self] _ in
            self?.viewModel.starButtonDidTapped()
        }, for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
    }
}

// private methods
extension RepositoryDetailViewController {
    private func setViews() {
        view.backgroundColor = .white

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        starButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)
        view.addSubview(textView)
        view.addSubview(starButton)

        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true

        textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true

        starButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        starButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        starButton.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 20).isActive = true
        starButton.setContentHuggingPriority(.required, for: .horizontal)
    }

    private func bind() {
        viewModel.$repository.sink { [weak self] in
            guard let self else { return }
            navigationItem.title = $0.name
            titleLabel.text = $0.fullName
            textView.text = $0.description
        }.store(in: &cancellabled)
    }
}
