//
//  RepoDetailContract.swift
//  GitHub
//
//  Created by Sasikumar JP on 12/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

protocol RepoDetailPresenterInput {
    var isLoading: Bool { get }
}

protocol RepoDetailInteractorInput {
}

protocol RepoDetailInteractorOutput : class {
}

protocol RepoDetailView : class {
    func showErrorMessage(errorMessage: String)
}