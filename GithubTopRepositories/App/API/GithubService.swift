//
//  GithubService.swift
//  GithubTopRepositories
//
//  Created by Bryan A Bolivar M on 12/7/18.
//  Copyright © 2018 Dev. All rights reserved.
//

import Foundation
import Moya

enum GithubService {
    case mostPopularRepos(q: String, order: String, sort: String)
}

extension GithubService: TargetType {
    var baseURL: URL { return URL(string: "https://api.github.com")! }

    var path: String {
        switch self {
        case .mostPopularRepos:
            return "/search/repositories"
        }
    }

    var method: Moya.Method {
        switch self {
        case .mostPopularRepos:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .mostPopularRepos(let q, let order, let sort):
            return .requestParameters(parameters: ["q": q, "order": order, "sort": sort], encoding: URLEncoding.default)
        }
    }

    var sampleData: Data {
        switch self {
        case .mostPopularRepos:
            return "{}".utf8Encoded
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
