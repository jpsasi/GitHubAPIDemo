//
//  RepoDetailPresenter.swift
//  GitHub
//
//  Created by Sasikumar JP on 12/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

class RepoDetailPresenter {
    var interactor: RepoDetailInteractorInput!
    weak var repoDetailView: RepoDetailView!
    var isLoading: Bool = false
}

extension RepoDetailPresenter: RepoDetailPresenterInput {
    
    func loadOpenIssues(repoUrl: String) {
        if !isLoading {
            isLoading = true
            runInBackgroundQueue({ 
            })
        }
    }
}

extension RepoDetailPresenter : RepoDetailInteractorOutput { 
}