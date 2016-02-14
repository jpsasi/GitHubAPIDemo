//
//  RepoIssueViewModel.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

struct RepoIssueViewModel {
    let issueNumber: Int
    let title: String
    let issueUrl: String
    let state: String
    let body: String
    let createdDateString: String
    let updatedDateString: String

    static func createRepoIssueViewModel(issue: GitHubRepositoryIssue) -> RepoIssueViewModel {
        let createDateString = issue.createdDate?.shortDateString() ?? ""
        let updateDateString = issue.updatedDate?.shortDateString() ?? ""
        return RepoIssueViewModel(issueNumber: issue.issueNumber, title: issue.title, issueUrl: issue.issueUrl, state: issue.state, body: issue.body, createdDateString: createDateString, updatedDateString: updateDateString)
    }
    
    static func createRepoIssueViewModels(issues: [GitHubRepositoryIssue]) -> [RepoIssueViewModel] {
        var viewModels = [RepoIssueViewModel]()
        for issue in issues {
            viewModels.append(createRepoIssueViewModel(issue))
        }
        return viewModels
    }
}