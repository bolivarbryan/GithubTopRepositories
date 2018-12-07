//
//  RepositoriesListViewController.swift
//  GithubTopRepositories
//
//  Created by Bryan A Bolivar M on 12/7/18.
//  Copyright © 2018 Dev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoriesListViewController: UIViewController {

    //MARK: - Properties

    let viewModel = RepositoriesListViewModel()
    let disposeBag = DisposeBag()
    let cellIdentifier = "cellIdentifier"
    let refreshControl = UIRefreshControl()

    @IBOutlet weak var repositoriesTableView: UITableView! {
        didSet {
            refreshControl.addTarget(self, action:  #selector(self.fetchRepositories), for: .valueChanged)
            refreshControl.tintColor = UIColor.red
            repositoriesTableView.refreshControl = refreshControl
        }
    }

    //MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModelToTableView()
        viewModel.fetchTopRepositories()
    }

    //MARK: Functions

    @objc func fetchRepositories() {
        viewModel.fetchTopRepositories()
    }

    func bindViewModelToTableView() {
        viewModel.repositories.asObservable()
            .bind(to: repositoriesTableView.rx.items(cellIdentifier: cellIdentifier,
                                         cellType: UITableViewCell.self)) { index, model, cell in
                                            cell.textLabel?.text = model.name
                                            cell.detailTextLabel?.text = model.language
            }
            .disposed(by: disposeBag)

        viewModel.repositories.asObservable()
            .subscribe(onNext:{ [weak self ]_ in
                self?.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
    }
}

