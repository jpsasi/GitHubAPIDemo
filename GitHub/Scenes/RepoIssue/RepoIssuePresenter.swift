//
//  RepoIssuePresenter.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

class RepoIssuePresenter {
    var interactor: RepoIssueInteractorInput!
    weak var repoIssueView: RepoIssueView!
    var isLoading: Bool = false
}

extension RepoIssuePresenter: RepoIssuePresenterInput {

    func loadIssues(repoUrl: String) {
        if !isLoading {
            isLoading = true
            repoIssueView.showProgress(true)
            runInBackgroundQueue({ 
                self.interactor.fetchIssues(repoUrl)
            })
        }
    }
}

extension RepoIssuePresenter : RepoIssueInteractorOutput {
    
    func fetchedIssues(result: ApiClientResult<[GitHubRepositoryIssue]>) {
        
        switch result {
        case .Success(let issues):
            let viewModels = RepoIssueViewModel.createRepoIssueViewModels(issues)
            self.isLoading = false
            runInMainQueue({
                self.repoIssueView.showProgress(false)
                self.repoIssueView.showIssues(viewModels)
            })
        case .Failure(let apiClientError):
            self.isLoading = false
            runInMainQueue({
                self.repoIssueView.showProgress(false)
                self.repoIssueView.showErrorMessage(apiClientError.description)
            })
        }
    }
}