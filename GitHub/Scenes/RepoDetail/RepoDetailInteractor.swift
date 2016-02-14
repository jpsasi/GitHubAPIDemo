//
//  RepoDetailInteractor.swift
//  GitHub
//
//  Created by Sasikumar JP on 12/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

class RepoDetailInteractor {
    weak var output: RepoDetailInteractorOutput!
    let gitHubApiService: GitHubApiService
    
    init(apiService: GitHubApiService) {
        gitHubApiService = apiService
    }
}

extension RepoDetailInteractor : RepoDetailInteractorInput {    
}