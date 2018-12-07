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
    let id: Int
    let name: String
    let forks: Int
    let language: String?

    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}

class GithubRepository: Codable {
    let repositories: [Item]

    enum CodingKeys: String, CodingKey {
        case repositories = "items"
    }
}
