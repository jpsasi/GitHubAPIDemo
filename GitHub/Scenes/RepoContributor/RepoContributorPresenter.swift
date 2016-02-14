//
//  RepoContributorPresenter.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

class RepoContributorPresenter {
    var interactor: RepoContributorInteractorInput!
    weak var contributorView: RepoContributorView!
    var isLoading: Bool = false
}

extension RepoContributorPresenter : RepoContributorPresenterInput {
    
    func loadContributors(contributorUrl: String) {
        if !isLoading {
            isLoading = true
            contributorView.showProgress(true)
            runInBackgroundQueue({ 
                self.interactor.fetchContributors(contributorUrl)
            })
        }
    }
}

extension RepoContributorPresenter : RepoContributorInteractorOutput {
    
    func fetchedContributors(result: ApiClientResult<[GitHubUser]>) {
        
        switch result {
        case .Success(let contributors):
            runInMainQueue({
                self.contributorView.showProgress(false)
                self.contributorView.showContributors(contributors)
            })
        case .Failure(let apiClientError):
            runInMainQueue({
                self.contributorView.showProgress(false)
                self.contributorView.showErrorMessage(apiClientError.description)
            })
        }
    }
}