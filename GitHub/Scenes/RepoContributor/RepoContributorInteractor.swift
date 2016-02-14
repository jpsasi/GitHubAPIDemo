//
//  RepoContributorInteractor.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

class RepoContributorInteractor {
    weak var output: RepoContributorInteractorOutput!
    let gitHubApiService: GitHubApiService
    
    init(apiService: GitHubApiService) {
        gitHubApiService = apiService
    }
}

extension RepoContributorInteractor : RepoContributorInteractorInput {
    
    func fetchContributors(contributorUrl: String) {
        gitHubApiService.fetchRepoContibutors(contributorUrl) { (result) in
            self.output.fetchedContributors(result)
        }
    }
}