//
//  RepoContributorConfigurator.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

class RepoContributorConfigurator {
    
    func configure(viewController: RepoContributorViewController) {
        let presenter = RepoContributorPresenter()
        let interactor = RepoContributorInteractor(apiService: GitHubApiService.sharedInstance)
        
        // View -> Presenter
        viewController.presenter = presenter
        
        // Presenter -> Interactor
        presenter.interactor = interactor
        
        // Interactor -> Presenter
        interactor.output = presenter
        
        // Presenter -> View
        presenter.contributorView = viewController
    }
}