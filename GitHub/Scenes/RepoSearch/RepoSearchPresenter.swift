//
//  RepoSearchPresenter.swift
//  GitHub
//
//  Created by Sasikumar JP on 11/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

class RepoSearchPresenter {
    var interactor: RepoSearchInteractorInput!
    weak var searchView: RepoSearchView!
    var isLoading: Bool = false
}

extension RepoSearchPresenter : RepoSearchPresenterInput {
        
    func loadRepoWithLanguage(language: String) {
        if !isLoading {
            isLoading = true
            runInBackgroundQueue({ 
                self.interactor.fetchRepoWithLanguage(language)
            })
        }
    }    
}

extension RepoSearchPresenter : RepoSearchInteractorOutput {
    
    func fetchedRespositoriesResult(result: ApiClientResult<[GitHubRepository]>) {
        
        switch result {
        case .Success(let repositories):
            let viewModels = RepoSearchViewModel.createRepoSearchViewModels(repositories)
            runInMainQueue {
                self.isLoading = false
                self.searchView.showRepositories(viewModels)
            }
        case .Failure(let apiClientError):
            runInMainQueue {
                self.isLoading = false
                self.searchView.showError(apiClientError.description)
            }
            break
        }
    }
}