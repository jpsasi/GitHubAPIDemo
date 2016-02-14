//
//  RepoIssueDetailInteractor.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

class RepoIssueDetailInteractor {

    weak var output: RepoIssueDetailInteractorOutput!
    let gitHubApiService: GitHubApiService
    
    init(apiService: GitHubApiService) {
        gitHubApiService = apiService
    }
}

extension RepoIssueDetailInteractor : RepoIssueDetailInteractorInput {
    
}

