//
//  Owner.swift
//  GithubTopRepositories
//
//  Created by Bryan A Bolivar M on 12/7/18.
//  Copyright © 2018 Dev. All rights reserved.
//

import Foundation

struct Owner: Codable {
    let login: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
    
}
