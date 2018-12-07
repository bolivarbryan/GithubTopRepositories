//
//  RepositoryTests.swift
//  GithubTopRepositoriesTests
//
//  Created by Bryan A Bolivar M on 12/7/18.
//  Copyright © 2018 Dev. All rights reserved.
//

import XCTest
@testable import GithubTopRepositories

class RepositoryTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testInvalidRepositoryFormat() {
        // given
        let owner = Owner(login: "Bryan", avatarURL: "")
        let item = Repository(id: 1, name: "freeCodeCamp", forks: 20590, language: "Swift", description: "hello world", stargazersCount: 0, owner:owner)

        let inputJSON = """
                        {
                          "items": [
                            {
                              "id": 1,
                              "name": "freeCodeCamp",
                              "forks": 20590,
                              "description": "hello world",
                              "stargazers_count": 0,
                              "owner": {
                                "login": "Bryan",
                                "avatar_url": ""
                              }
                            }
                          ]
                        }
                        """.data(using: .utf8)!
        // then

        let githubRepository =  try? JSONDecoder().decode(GithubRepository.self, from: inputJSON)
        XCTAssertNotNil(githubRepository, "Decoding failed, check input json")

        guard let ghRepository = githubRepository else {

            // Note: I Never should fatalError for App Target, the app never should be closed or terminated. better use assertionFailure

            fatalError("githubRepository should be nil, got \(String(describing: githubRepository))")
        }

        XCTAssert(ghRepository.repositories.first == item, "Repositories should contain the same value, check Equatable protocol")
    }
}
