//
//  RepoIssueContract.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

protocol RepoIssuePresenterInput {
    func loadIssues(repoUrl: String)
}

protocol RepoIssueInteractorInput {
    func fetchIssues(repoUrl: String)
}

protocol RepoIssueInteractorOutput : class {
    func fetchedIssues(result: ApiClientResult<[GitHubRepositoryIssue]>)
}

protocol RepoIssueView : class {
    func showProgress(loading: Bool)
    func showIssues(issues: [RepoIssueViewModel])
    func showErrorMessage(message: String)
}