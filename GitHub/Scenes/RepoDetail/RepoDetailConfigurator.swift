//
//  RepoDetailConfigurator.swift
//  GitHub
//
//  Created by Sasikumar JP on 12/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

class RepoDetailConfigurator {
    
    class var sharedInstance: RepoDetailConfigurator {
        struct Static {
            static var instance: RepoDetailConfigurator?
            static var token: dispatch_once_t = 0
        }
    
        dispatch_once(&Static.token) {
            Static.instance = RepoDetailConfigurator()
        }
        return Static.instance!
    }
    
    func configure(viewController: RepoDetailViewController) {
        let presenter = RepoDetailPresenter()
        let interactor = RepoDetailInteractor(apiService: GitHubApiService.sharedInstance)
        
        // View -> Presenter
        viewController.presenter = presenter
        
        // Presenter -> Interactor
        presenter.interactor = interactor
        
        // Interactor -> Presenter
        interactor.output = presenter
        
        // Presenter -> View
        presenter.repoDetailView = viewController
        
    }
}