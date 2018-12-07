//
//  RepositoriesListViewModel.swift
//  GithubTopRepositories
//
//  Created by Bryan A Bolivar M on 12/7/18.
//  Copyright © 2018 Dev. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class RepositoriesListViewModel {

    let provider = MoyaProvider<GithubService>()
    let repositories: Variable<[Repository]> = Variable([])

    @objc func fetchTopRepositories() {
        provider.request(.mostPopularRepos(q: "stars:>1", order: "desc", sort: "stars")) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let repositories = try JSONDecoder().decode(GithubRepository.self, from: data)
                    self.repositories.value = repositories.repositories
                } catch {
                    print(error.localizedDescription)
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
