//
//  RepoIssueDetailPresenter.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

class RepoIssueDetailPresenter {
    var interactor: RepoIssueDetailInteractorInput!
    weak var repoIssueDetailView: RepoIssueDetailView!
}

extension RepoIssueDetailPresenter : RepoIssueDetailPresenterInput {
    
}

extension RepoIssueDetailPresenter : RepoIssueDetailInteractorOutput {
    
}