//
//  SearchViewController.swift
//  GitHub_SearchRepository
//
//  Created by satoshi on 2024/04/24.
//

import UIKit

final class SearchViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)

        Task {
            let hoge = await APIClient().getRepository(.init(keyword: "tosh7"))
            print(hoge)
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

