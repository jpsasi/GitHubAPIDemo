//
//  RepoSearchContract.swift
//  GitHub
//
//  Created by Sasikumar JP on 11/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

/**
 *  Event Handler Contract
 */
protocol RepoSearchPresenterInput {
    func loadRepoWithLanguage(language: String)
}

/**
 *  Task Handler Contract
 */
protocol RepoSearchInteractorInput {
    func fetchRepoWithLanguage(language: String)
}

/// Task Handler Output Contract
protocol RepoSearchInteractorOutput : class {
    func fetchedRespositoriesResult(result: ApiClientResult<[GitHubRepository]>)
}

/// Task Handler output to display contract
protocol RepoSearchView : class {
    func showRepositories(repositoriesViewModel: [RepoSearchViewModel])
    func showError(errorString: String)
}
