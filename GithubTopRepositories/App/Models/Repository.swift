//
//  Repository.swift
//  GithubTopRepositories
//
//  Created by Bryan A Bolivar M on 12/7/18.
//  Copyright © 2018 Dev. All rights reserved.
//

import Foundation

typealias Repository = Item

struct Item: Codable, Equatable {
    private let id: Int
    private let name: String
    private let forks: Int
    private let language: String?
    private let description: String
    private let stargazersCount: Int
    private let owner: Owner

    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }

    var details: String {
        return "Description: \n\n\(description) \n\nStarGazers: \n\n\(stargazersCount)"
    }

    var repositoryName: String {
        return name
    }

    var repositoryLanguage: String {
        return language ?? "No Specified"
    }

    var ownerAvatarUrl: URL? {
        return URL(string: owner.avatarURL)
    }

    enum CodingKeys: String, CodingKey {
        case id, name, forks, language, description, owner
        case stargazersCount = "stargazers_count"
    }

    init(id: Int, name: String, forks: Int, language: String, description: String, stargazersCount: Int, owner: Owner) {
        self.id = id
        self.name = name
        self.forks = forks
        self.language = language
        self.description = description
        self.stargazersCount = stargazersCount
        self.owner = owner
    }
}

class GithubRepository: Codable {
    let repositories: [Item]

    enum CodingKeys: String, CodingKey {
        case repositories = "items"
    }
}
