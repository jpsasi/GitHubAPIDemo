//
//  RepoIssueInteractor.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

class RepoIssueInteractor {
    weak var output: RepoIssueInteractorOutput!
    let gitHubApiService: GitHubApiService
    
    init(apiService: GitHubApiService) {
        gitHubApiService = apiService
    }

}

extension RepoIssueInteractor : RepoIssueInteractorInput {
    
    func fetchIssues(repoUrl: String) {
        gitHubApiService.fetchRepositoryOpenIssues(repoUrl) { (result) in
            self.output.fetchedIssues(result)
        }
    }
}