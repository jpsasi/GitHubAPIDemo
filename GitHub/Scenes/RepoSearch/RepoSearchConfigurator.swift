//
//  RepoSearchConfigurator.swift
//  GitHub
//
//  Created by Sasikumar JP on 11/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

class RepoSearchConfigurator {
    
    class var sharedInstance: RepoSearchConfigurator {
        struct Static {
            static var instance: RepoSearchConfigurator?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = RepoSearchConfigurator()
        }
        
        return Static.instance!
    }
    
    func configure(viewController: RepoSearchViewController) {
        let presenter = RepoSearchPresenter()
        let interactor = RepoSearchInteractor(apiService: GitHubApiService.sharedInstance)
        
        // View => Presenter
        viewController.presenter = presenter
        
        // Presenter => Interactor
        presenter.interactor = interactor
        
        // Interactor => Presenter
        interactor.output = presenter
        
        // Presenter => View
        presenter.searchView = viewController
        
    }
}