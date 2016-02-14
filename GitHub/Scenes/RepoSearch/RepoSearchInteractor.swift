//
//  RepoSearchInteractor.swift
//  GitHub
//
//  Created by Sasikumar JP on 11/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

class RepoSearchInteractor {
    weak var output: RepoSearchInteractorOutput!
    let gitHubApiService: GitHubApiService
    
    init(apiService: GitHubApiService) {
        gitHubApiService = apiService
    }
}

extension RepoSearchInteractor : RepoSearchInteractorInput {
        
    func fetchRepoWithLanguage(language: String) {
        gitHubApiService.fetchGitHubRepositoriesByLanguage(language) { result in
            self.output.fetchedRespositoriesResult(result)
        }
    }    
}