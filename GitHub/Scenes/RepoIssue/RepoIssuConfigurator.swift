//
//  RepoIssuConfigurator.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

class RepoIssueConfigurator {
    
    func configure(viewController: RepoIssueViewController) {
        let presenter = RepoIssuePresenter()
        let interactor = RepoIssueInteractor(apiService: GitHubApiService.sharedInstance)
        
        // View -> Presenter
        viewController.presenter = presenter
        
        // Presenter -> Interactor
        presenter.interactor = interactor
        
        // Interactor -> Presenter
        interactor.output = presenter
        
        // Presenter -> View
        presenter.repoIssueView = viewController
    }
}