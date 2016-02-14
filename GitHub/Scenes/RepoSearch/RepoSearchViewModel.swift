//
//  RepoSearchViewModel.swift
//  GitHub
//
//  Created by Sasikumar JP on 11/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

struct RepoSearchViewModel : Equatable {
    let repoName: String
    let repoDescription: String
    let avatarUrl: String
    let language: String
    let watchers: Int
    let forks: Int
    let stars: Int
    let repoUrl: String
    let contributorUrl: String
    
    static func createRepoSearchViewModel(repository: GitHubRepository) -> RepoSearchViewModel {
        return RepoSearchViewModel(
            repoName: repository.name,
            repoDescription: repository.repoDescription,
            avatarUrl: repository.owner.avatarUrl,
            language: repository.language,
            watchers: repository.watchers,
            forks: repository.forks,
            stars: repository.stars,
            repoUrl: repository.repoUrl,
            contributorUrl: repository.contributorUrl)
    }
    
    static func createRepoSearchViewModels(repositories: [GitHubRepository]) -> [RepoSearchViewModel] {
        var viewModels: [RepoSearchViewModel] = []
        for repository in repositories {
            viewModels.append(createRepoSearchViewModel(repository))
        }
        return viewModels
    }
}

func ==(lhs: RepoSearchViewModel, rhs: RepoSearchViewModel) -> Bool {
    return lhs.repoName == rhs.repoName && lhs.repoUrl == rhs.repoUrl
}