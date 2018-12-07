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
    fileprivate static let detailsSegueIdentifier = "RepositoryDetailsSegue"
    fileprivate let cellIdentifier = "cellIdentifier"
    fileprivate let viewModel = RepositoriesListViewModel()
    fileprivate let disposeBag = DisposeBag()
    fileprivate let refreshControl = UIRefreshControl()

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

     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? RepositoryDetailsViewController {
            vc.item = viewModel.selectedItem
        }
     }

    //MARK: Functions

    @objc func fetchRepositories() {
        viewModel.fetchTopRepositories()
    }

    func bindViewModelToTableView() {
        viewModel.repositories.asObservable()
            .bind(to: repositoriesTableView.rx.items(cellIdentifier: cellIdentifier,
                                         cellType: UITableViewCell.self)) { index, model, cell in
                                            cell.textLabel?.text = model.repositoryName
                                            cell.detailTextLabel?.text = model.repositoryLanguage
            }
            .disposed(by: disposeBag)

        viewModel.repositories.asObservable()
            .subscribe(onNext:{ [weak self ]_ in
                self?.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)

        repositoriesTableView.rx.modelSelected(Repository.self)
            .subscribe(onNext: { [weak self] model in
                self?.viewModel.selectedItem = model
                self?.performSegue(withIdentifier: RepositoriesListViewController.detailsSegueIdentifier, sender: self)
            })
        .disposed(by: disposeBag)
    }
}
