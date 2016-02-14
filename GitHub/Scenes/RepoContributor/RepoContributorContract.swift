//
//  RepoContributorContract.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

protocol RepoContributorPresenterInput {
    
    func loadContributors(contributorUrl: String)
}

protocol RepoContributorInteractorInput {
    
    func fetchContributors(contributorUrl: String)
}

protocol RepoContributorInteractorOutput : class {
    
    func fetchedContributors(result: ApiClientResult<[GitHubUser]>)
}

protocol RepoContributorView : class {
    func showProgress(loading: Bool)
    func showContributors(contributors: [GitHubUser])
    func showErrorMessage(message: String)
}