//
//  RepoSearchPresenterTests.swift
//  GitHub
//
//  Created by Sasikumar JP on 14/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import XCTest
@testable import GitHub

class RepoSearchPresenterTests: XCTestCase {
    
    var sut: RepoSearchPresenter!
    
    override func setUp() {
        super.setUp()
        setupPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func setupPresenter() {
        sut = RepoSearchPresenter()
    }
    
    //MARK: Test Doubles
    class RepoSearchInteractorSpy : RepoSearchInteractorInput {
        
        var fetchRepoMethodCalled = false
        
        func fetchRepoWithLanguage(language: String) {
            fetchRepoMethodCalled = true
        }
    }
    
    class RepoSearchViewSpy: NSObject, RepoSearchView {
    
        var showErrorMethodCalled = false
        var showRepositoriesCalled = false
        
        func showRepositories(repositoriesViewModel: [RepoSearchViewModel]) {
            showRepositoriesCalled = true
        }
        
        func showError(errorString: String) {
            showErrorMethodCalled = true
        }
    }
    
    func testLoadRepoShouldCallInteractorToFetchRepo() {
        
        // Given
        let interactor = RepoSearchInteractorSpy()
        sut.interactor = interactor
        
        // When
        sut.loadRepoWithLanguage("")
        
        let timeOutDate = NSDate(timeIntervalSinceNow: 2.0)
        while (!interactor.fetchRepoMethodCalled && (timeOutDate.timeIntervalSinceNow > 0)) {
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.01, true)
        }

        // Then
        XCTAssert(interactor.fetchRepoMethodCalled, "Presenter should call Interactor to fetchGitHubRepositories")
    }
    
    func testFetchedSuccessResultsShouldCallShowRepositories() {
        // Given
        let repoView = RepoSearchViewSpy()
        sut.searchView = repoView
        
        let owner = GitHubUser(userId: 1, login: "jpsasi", avatarUrl: "http://jpsasikumar.com", followersUrl: "http://jpsasikumar.com", followingUrl: "http://jpsasikumar.com")
        
        let repository = GitHubRepository(repositoryId: 1, name: "Swift", repoDescription: "Swift Project", createdAt: "1997", language: "Swift", watchers: 10, forks: 10, stars: 10, owner: owner, isPrivate: false, repoUrl: "http://jpsasikumar.com", contributorUrl: "http://jpsasikumar.com")
        
        let result = ApiClientResult.Success([repository])
        
        // When
        sut.fetchedRespositoriesResult(result)
        let timeOutDate = NSDate(timeIntervalSinceNow: 2.0)
        while (!repoView.showRepositoriesCalled && (timeOutDate.timeIntervalSinceNow > 0)) {
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.01, true)
        }
        
        // Then
        XCTAssert(repoView.showRepositoriesCalled, "Presenter should pass the results to RepoSearchView to Display")
    }

    func testFetchedFailureResultsShouldCallShowError() {
        // Given
        let repoView = RepoSearchViewSpy()
        sut.searchView = repoView
        
        let result = ApiClientResult<[GitHubRepository]>.Failure(.ClientError(422))
        
        // When
        sut.fetchedRespositoriesResult(result)

        let timeOutDate = NSDate(timeIntervalSinceNow: 5.0)
        while (!repoView.showErrorMethodCalled && (timeOutDate.timeIntervalSinceNow > 0)) {
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.01, true)
        }

        // Then
        XCTAssert(repoView.showErrorMethodCalled, "Presenter should pass the error results RepoSearchView to Display")
    }

}
